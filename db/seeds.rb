# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

# Super user setup
dummy = User.create({display_name: "admin"})
dummy.creator_id = dummy.id
dummy.updater_id = dummy.id
dummy.save



case Rails.env
  when "development"
    # projects
    p1 = Project.create({description: "I'm a project, I'm a project, I'm a project!", name: "test proj", notes:{}, urn:"http://localhost:3000/projects/test_proj"})
    p1.creator_id = p1.updater_id = dummy.id
    p1.save!

    p2 = Project.create({description: "I'm another project, I'm another project, I'm another project!", name: "test proj another", notes:{}, urn:"http://localhost:3000/projects/test_proj_another"})
    p2.creator_id = p2.updater_id = dummy.id
    p2.save!

    p3 = Project.create({description: "I'm a project an i'm ok - ish...", name: "test proj-ish", notes:{}, urn:"http://localhost:3000/projects/test_proj-ish"})
    p3.creator_id = p3.updater_id = dummy.id
    p3.save!

    # sites
    s1 = Site.create({name: "Site 1", notes:{:a_note => :hello}, latitude:-27.472778, longitude: 153.027778})
    s1.creator_id = s1.updater_id = dummy.id
    s1.projects.push p1
    s1.save!

    s2 = Site.create({name: "Site 2", notes:{:my_note => :waves}, latitude:-27.472778, longitude: 153.027778})
    s2.creator_id = s2.updater_id = dummy.id
    s2.projects.push p2, p1
    s2.save!

    s3 = Site.create({name: "Site 3", notes:{:this_note => :scowls}, latitude:-27.472778, longitude: 153.027778})
    s3.creator_id = s3.updater_id = dummy.id
    s3.projects.push p3
    s3.save!

    # photos
    photo1 = Photo.create({description:"I'm a little photo, short and stout.", copyright:"That guy over there", uri:"http://upload.wikimedia.org/wikipedia/commons/thumb/1/18/Bartagame_fcm.jpg/250px-Bartagame_fcm.jpg"})
    photo1.save!

    # audio recordings
    AudioRecording.send(:attr_accessible, :uuid)

    ar1_uuid = '1bd0d668-1471-4396-adc3-09ccd8fe949a'
    #recorded_date:'2012/11/06',
    ar1 = AudioRecording.create({uuid:ar1_uuid,  media_type:'audio/wavpack', status:'ready',
                                 recorded_date:'2012/11/06', duration_seconds: 120.0, sample_rate_hertz: 22050,
                                channels: 1, bit_rate_bps:171000, data_length_bytes: 2560180, file_hash: 'MD5::EFB5B76BE5FD1F0D19CD5FE692AF1FC2' })
    ar1.creator_id = ar1.updater_id = ar1.user_id = dummy.id
    ar1.site = s1
    ar1.save!

    ar1.uuid = ar1_uuid
    ar1.save!

    AudioRecording.send(:attr_protected, :uuid)

  when "production"

  when "test"
    # these seeds should be put in the fixtures folder
end