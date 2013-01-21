require 'database_cleaner'

def ids(obj)
  obj.creator_id = @admin_id
  obj.updater_id = @admin_id
  obj
end

def sv(obj)
  obj.save!
  obj
end

def add(obj)
  sv(ids(obj))
end

def run_dev_seeds(admin_id)

  # clear database
  #puts 'Cleaning database...'
  #DatabaseCleaner.strategy = :truncation
  #DatabaseCleaner.clean

  @admin_id = admin_id

  # if these two users exist, assume seeds have already been run, and do not run again
  if !User.where(:display_name => 'A normal user').first.blank? && !User.where(:display_name => 'A complicated user').first.blank?
    puts 'Extra users already exist, assuming seeds have already been run, exiting...'
    return
  end

  # other users
  puts "Creating other users..."
  u1 = add User.create({ user_name: 'normal_user', display_name: 'A normal user', email: 'example+normal@example.com', password: Devise.friendly_token[0,20] })
  u2 = add User.create({ user_name: 'complicated_user', display_name: 'A complicated user', email: 'example+complicated@example.com', password: Devise.friendly_token[0,20] })

  # projects
  puts "Creating projects..."
  p1 = add (Project.create({ description: "SERF Acoustic study aimed at detecting the <__> species",
                             name:        "SERF AS Frogs", notes: { }, urn: "urn:http://localhost:3000/projects/serf_as_frogs"
                           }))

  p2 = add (Project.create({ description: "Groote Island project dedicated to preventing canetoad infestation",
                             name:        "Groote Canetoad", notes: { }, urn: "urn:http://localhost:3000/projects/groote_canetoad",
                           }))

  p3 =add (Project.create({ description: "Collaborative study reusing data from several projects to monitor Koala calls",
                            name:        "Qubar Collaborative", notes: { }, urn: "urn:http://localhost:3000/projects/qubar_collaborative",
                          }))


  # sites
  puts "Creating Sites..."
  s1 = ids Site.create({name: "South East", notes:{:environment => "wet"}, latitude:-27.472778, longitude: 153.027778})
  s1.projects.push p1, p3
  sv s1

  s2 = ids Site.create({name: "North East", notes:{:environment => "dry scrub"}, latitude:-27.472778, longitude: 153.027778})
  s2.projects.push p1, p3
  sv s2

  s3 = ids Site.create({name: "Beach", notes:{:this_note => :scowls}, latitude:-27.472778, longitude: 153.027778})
  s3.projects.push p2, p3
  sv s3

  # photos
  # photos -> sites
  puts "Creating Site Photos..."
  sv Photo.create({description:"Koala Climbing a tree", copyright:"Wikimedia CC 3.0",
                   uri:"http://upload.wikimedia.org/wikipedia/commons/4/49/Koala_climbing_tree.jpg",
                   imageable_type: "Site", imageable_id:p1.id })
  sv Photo.create({description:"Lizard", copyright:"Wikimedia CC 3.0",
                   uri:"http://upload.wikimedia.org/wikipedia/commons/thumb/1/18/Bartagame_fcm.jpg/250px-Bartagame_fcm.jpg",
                   imageable_type: "Site", imageable_id:p2.id })
  sv Photo.create({description:"Canetoad on a rock", copyright:"Wikimedia CC 3.0",
                   uri:"http://upload.wikimedia.org/wikipedia/commons/8/85/Bufo_marinus_from_Australia.JPG",
                   imageable_type: "Site", imageable_id:s3.id })

  # photos -> projects
  puts "Creating Project Photos..."
  sv Photo.create({description:"Koala Climbing  a tree", copyright:"Wikimedia CC 3.0",
                   uri:"http://upload.wikimedia.org/wikipedia/commons/4/49/Koala_climbing_tree.jpg",
                   imageable_type: "Project", imageable_id:p1.id })
  sv Photo.create({description:"Canetoad on a rock", copyright:"Wikimedia CC 3.0",
                   uri:"http://upload.wikimedia.org/wikipedia/commons/8/85/Bufo_marinus_from_Australia.JPG",
                   imageable_type: "Project", imageable_id:p2.id })
  sv Photo.create({description:"Jason Wimmer Deploying sensors", copyright:"Microsoft QUT eResearch center",
                   uri:"http://sensor.mquter.qut.edu.au/graphics/welcome1.jpg",
                   imageable_type: "Project", imageable_id:p3.id })


  # audio recordings
  puts "Creating Audiorecordings..."
  AudioRecording.send(:attr_accessible, :uuid)

  ar1_uuid = '1bd0d668-1471-4396-adc3-09ccd8fe949a'
  #recorded_date:'2012/11/06',
  ar1 = ids (AudioRecording.create({uuid:ar1_uuid,  media_type:'audio/wavpack', status: :ready,
                                    recorded_date:'2012/11/06', duration_seconds: 120.0, sample_rate_hertz: 22050,
                                    channels: 1, bit_rate_bps:171000, data_length_bytes: 2560180,
                                    file_hash: 'MD5::EFB5B76BE5FD1F0D19CD5FE692AF1FC2', status: 'ready' }))

  ar1.uploader_id = admin_id

  ar1.site = s1
  ar1.save!

  ar1.uuid = ar1_uuid
  ar1.save!

  AudioRecording.send(:attr_protected, :uuid)

  fake_readings =
      [
          ["4e01751b-b567-406c-af0a-c44f39f29f2c", s1],
          ["8a26c5cd-3f09-4b2f-b48c-142aff498483", s2],
          ["d49ba8d4-9dde-46c2-a04d-94aba66366c9", s3],
          ["f9f2b885-6f25-4fdb-8c53-e03dca3f7e8a", s1],
          ["13990e57-42a8-4b35-8eb0-1613bbb83bf6", s2]
      ]

  lengths = [120.0, 1440 * 60, 720 * 60]
  fake_readings.each { |row|
    time = rand(10.years).ago

    AudioRecording.send(:attr_accessible, :uuid)
    ar = ids (AudioRecording.create({uuid:row[0],  media_type:'audio/mp3', status: :ready,
                                     recorded_date:time, duration_seconds: lengths.sample, sample_rate_hertz: 22050,
                                     channels: 2, bit_rate_bps:171000, data_length_bytes: (rand * 10000).to_i,
                                     file_hash: 'INVALID', notes:{:fake => true}, status: 'new' }))
    ar.uploader_id = admin_id
    ar.site = row[1]
    sv ar
    AudioRecording.send(:attr_protected, :uuid)
  }

  # tags
  puts "Creating Tags..."
  dummy_tags =["Koala Bellow", "Eastern Koel", "Torresian Crow", "Sacred Kingfisher", "Lewin's Honeyeater", "Canetoad", "Crickets"]
  dummy_tags.each { |tagName|
    t = ids Tag.create({text: tagName, is_taxanomic: true})
    t.type_of_tag = :common_name
    sv t
  }

  # more types of tags
  add Tag.create({text: "caw", is_taxanomic: false, type_of_tag: :sounds_like})
  add Tag.create({text: "whistle", is_taxanomic: false, type_of_tag: :looks_like})
  add Tag.create({text: "repeating", is_taxanomic: false, type_of_tag: :looks_like})
  add Tag.create({text: "Corvus orru", is_taxanomic: true, type_of_tag: :species_name})

  # audo events
  puts "Creating Audio Events..."
  tags = Tag.all

  at1 = add( AudioEvent.create({start_time_seconds: 11.0, end_time_seconds: 13.5, low_frequency_hertz: 150,
                                high_frequency_hertz: 8000, is_reference: false, audio_recording_id: ar1.id}))


  at2 = add( AudioEvent.create({start_time_seconds: 1.0, end_time_seconds: 2.5, low_frequency_hertz: 1000,
                                high_frequency_hertz: 10000, is_reference: false, audio_recording_id: ar1.id}))

  at3 = add( AudioEvent.create({start_time_seconds: 5.2, end_time_seconds: 12.5, low_frequency_hertz: 200,
                                high_frequency_hertz: 2500, is_reference: false, audio_recording_id: ar1.id}))

  at4 = add( AudioEvent.create({start_time_seconds: 5.2, end_time_seconds: 12.5, low_frequency_hertz: 200,
                                high_frequency_hertz: 2500, is_reference: false, audio_recording_id: 2}))

  # audio events <-> tags
  puts "Linking audio events and tags..."
  add(at1.audio_event_tags.build(:tag => tags.select{|i| i.text == "Torresian Crow"}.first))
  add(at1.audio_event_tags.build(:tag => tags.select{|i| i.text == "caw"}.first))
  add(at1.audio_event_tags.build(:tag => tags.select{|i| i.text == "Corvus orru"}.first))

  add(at2.audio_event_tags.build(:tag => tags.select{|i| i.text == "Koala Bellow"}.first))

  add(at3.audio_event_tags.build(:tag => tags.select{|i| i.text == "Lewin's Honeyeater"}.first))
  add(at3.audio_event_tags.build(:tag => tags.select{|i| i.text == "repeating"}.first))

  add(at4.audio_event_tags.build(:tag => tags.select{|i| i.text == "Sacred Kingfisher"}.first))

  # bookmarks
  puts "Creating Bookmarks..."
  add(Bookmark.create({:audio_recording_id => ar1.id, :offset_seconds => 0, :name => 'start',
                       :notes => {:a_note => 'at the start of the recording'}}))
  add(Bookmark.create({:audio_recording_id => ar1.id, :offset_seconds => 50, :name => 'what\'s this?'}))

  # saved searches
  puts "Creating Saved Searches..."
  add(SavedSearch.create({:name => 'Goote', :search_object => Search.new( :body_params => { :project_ids => [2] } ).to_json}))
  add(SavedSearch.create({:name => 'Testing', :search_object => Search.new( :body_params => { :project_ids => [1, 2],
                                                                                              :site_ids => [1] } ).to_json}))

  # analysis scripts
  puts "Creating Analysis Scripts..."
  script1 = AnalysisScript.create({name: 'a_test_script', display_name: 'A Test Script', version: 'script version',
                                   description: 'script descr', settings: '\tmp', verified: false,
                                   extra_data: 'hi folks!' ,notes: {more: 'data'} })
  add(script1)

  # analysis jobs
  puts "Creating Analysis Jobs..."
  job1 = ids(AnalysisJob.create({name: 'A Test Job', description: 'job descr',notes: {more: 'data'} ,process_new: false,
                          script_name: script1.name, script_version: script1.version,
                          script_description: script1.description, script_settings: script1.settings,
                          script_display_name:script1.display_name, script_extra_data:script1.extra_data
                          }))

  job1.saved_search = SavedSearch.first
  add(job1)


  # analysis items
  puts "Creating Analysis Items..."
  ai1 = AnalysisItem.create({offset_start_seconds:10,offset_end_seconds:50, status: :ready})
  ai1.analysis_job = job1
  ai1.audio_recording = ar1
  sv(ai1)

  # permissions
  puts "Creating Permissions..."
  per1 = Permission.create({user_id: admin_id, level: :owner, permissionable_id: p1.id, permissionable_type: 'Project'})
  add(per1)

  # progresses
  puts "Creating Progresses..."
  offset_list =
    ([
        [0.0, 33.26],
        [60, 360],
        [720, 792.3654],
        [1600, 1632],
        [1750, 1894],
        [2400, 2520],
    ]).to_json

  prog1 = Progress.create({activity: ['annotating', 'listening', 'checklisting' ].sample, start_offset_seconds: Random.rand(20), end_offset_seconds:  (Random.rand(1000) + 2500), offset_list: offset_list })
  prog1.saved_search = SavedSearch.first
  prog1.audio_recording = AudioRecording.first
  add(prog1)

  # authorizations

end