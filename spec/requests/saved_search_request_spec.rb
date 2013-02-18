require 'spec_helper'

describe SavedSearchStore do
  include Shared

  describe "empty search" do
    it 'should return all available recordings' do
      # prepare
      u1 = create(:user)
      r1 = create(:audio_recording, user: u1, recorded_date: Time.current, duration_seconds: 350)
      r2 = create(:audio_recording, user: u1, recorded_date: Time.current, duration_seconds: 350)
      r3 = create(:audio_recording, user: u1, recorded_date: Time.current, duration_seconds: 350)

      the_search = SavedSearchStore.new({})

      # run
      data_set = the_search.execute_query

      # check
      data_set.items.size.should == 3

      data_set.items.each do |item|
        check_search_data_set_item(item)
      end
    end

    it 'should return no recordings' do
      # prepare
      # no recordings

      the_search = SavedSearchStore.new({})

      # run
      data_set = the_search.execute_query

      # check
      data_set.items.size.should == 0
    end

    it 'respects audio recording status' do
      # :new, :to_check, :ready, :corrupt, :ignore
      # not sure about this
      #r1 = create(:audio_recording, )
    end
  end

  describe 'matches audio recording ids' do
    it 'should return only one audio recording using id' do
      # prepare
      u1 = create(:user)
      r1 = create(:audio_recording, user: u1, recorded_date: Time.current, duration_seconds: 350)
      r2 = create(:audio_recording, user: u1, recorded_date: Time.current, duration_seconds: 350)
      r3 = create(:audio_recording, user: u1, recorded_date: Time.current, duration_seconds: 350)

      the_search = SavedSearchStore.new(body_params: {audio_recording_id: r1.id})

      # run
      data_set = the_search.execute_query

      # check
      data_set.items.size.should == 1

      data_set.items.each do |item|
        check_search_data_set_item(item, {id: [r1.id], uuid: [r1.uuid], start_offset_seconds: nil, start_offset_seconds: nil})
      end
    end

    it 'should return no recordings if none match the id' do
      # prepare
      u1 = create(:user)
      r1 = create(:audio_recording, user: u1, recorded_date: Time.current, duration_seconds: 350)
      r2 = create(:audio_recording, user: u1, recorded_date: Time.current, duration_seconds: 350)
      r3 = create(:audio_recording, user: u1, recorded_date: Time.current, duration_seconds: 350)

      the_search = SavedSearchStore.new(body_params: {audio_recording_id: 1000})

      # run
      data_set = the_search.execute_query

      # check
      data_set.items.size.should == 0
    end

    it 'should raise an error for an invalid id' do
      # prepare
      u1 = create(:user)
      r1 = create(:audio_recording, recorded_date: Time.current, duration_seconds: 350)

      # run
      expect {
        the_search = SavedSearchStore.new(body_params: {audio_recording_id: -10})

        data_set = the_search.execute_query
      }.to raise_error(ArgumentError, 'SavedSearchStoreBody has errors: {"audio_recording_id":["must be greater than or equal to 1"]}.')

      # check

    end

    it 'should return only one audio recording using uuid' do
      # prepare
      u1 = create(:user)
      r1 = create(:audio_recording, user: u1, recorded_date: Time.current, duration_seconds: 350)
      r2 = create(:audio_recording, user: u1, recorded_date: Time.current, duration_seconds: 350)
      r3 = create(:audio_recording, user: u1, recorded_date: Time.current, duration_seconds: 350)

      the_search = SavedSearchStore.new(body_params: {audio_recording_uuid: r1.uuid})

      # run
      data_set = the_search.execute_query

      # check
      data_set.items.size.should == 1

      data_set.items.each do |item|
        check_search_data_set_item(item, {id: [r1.id], uuid: [r1.uuid], start_offset_seconds: nil, start_offset_seconds: nil})
      end
    end

    it 'should return no recordings if none match the uuid' do
      # prepare
      u1 = create(:user)
      r1 = create(:audio_recording, user: u1, recorded_date: Time.current, duration_seconds: 350)
      r2 = create(:audio_recording, user: u1, recorded_date: Time.current, duration_seconds: 350)
      r3 = create(:audio_recording, user: u1, recorded_date: Time.current, duration_seconds: 350)

      the_search = SavedSearchStore.new(body_params: {audio_recording_uuid: UUIDTools::UUID.random_create.to_s})

      # run
      data_set = the_search.execute_query

      # check
      data_set.items.size.should == 0
    end

    it 'should raise an error for an invalid uuid' do
      # prepare
      u1 = create(:user)
      r1 = create(:audio_recording, recorded_date: Time.current, duration_seconds: 350)

      # run
      expect {
        the_search = SavedSearchStore.new(body_params: {audio_recording_uuid: '3465345dfgdfgfd'})

        data_set = the_search.execute_query
      }.to raise_error(ArgumentError, 'SavedSearchStoreBody has errors: {"audio_recording_uuid":["is the wrong length (should be 36 characters)","must be a valid UUID, given String with value 3465345dfgdfgfd."]}.')

      # check

    end

  end
  describe 'projects' do
    it 'should raise an error for project ids less than 0' do
      # prepare
      u1 = create(:user)
      r1 = create(:audio_recording, recorded_date: Time.current, duration_seconds: 350)

      # run
      expect {
        the_search = SavedSearchStore.new(body_params: {project_id: -10})

        data_set = the_search.execute_query
      }.to raise_error(ArgumentError, 'SavedSearchStoreBody has errors: {"project_id":["must be greater than or equal to 1"]}.')

      # check

    end

    it 'should raise an error for project ids less than 1' do
      # prepare
      u1 = create(:user)
      r1 = create(:audio_recording, recorded_date: Time.current, duration_seconds: 350)

      # run
      expect {
        the_search = SavedSearchStore.new(body_params: {project_id: 0})

        data_set = the_search.execute_query
      }.to raise_error(ArgumentError, 'SavedSearchStoreBody has errors: {"project_id":["must be greater than or equal to 1"]}.')

      # check

    end

    it 'should get the matching audio recording using a single project id' do
      # prepare
      u1 = create(:user)
      r1 = create(:audio_recording, recorded_date: Time.current, duration_seconds: 350)
      r2 = create(:audio_recording, recorded_date: Time.current, duration_seconds: 350)

      the_search = SavedSearchStore.new(body_params: {project_id: r2.site.projects.collect { |p| p.id }.first})


      # run
      data_set = the_search.execute_query

      # check

      data_set.items.size.should == 1

      data_set.items.each do |item|
        check_search_data_set_item(item, {id: [r2.id], uuid: [r2.uuid], start_offset_seconds: nil, start_offset_seconds: nil})
      end
    end

    it 'should get the matching audio recording using multiple project ids' do
      # prepare
      # 3 projects, 3 sites, 4 recordings
      p1 = create(:project)
      s1 = create(:site, projects: [p1])
      r1 = create(:audio_recording, site: s1)
      r2 = create(:audio_recording, site: p1.sites.first)
      r3 = create(:audio_recording)
      r4 = create(:audio_recording)

      the_search = SavedSearchStore.new(body_params: {project_id: p1.id})


      # run
      data_set = the_search.execute_query

      # check
      data_set.items.size.should == 2

      data_set.items.each do |item|
        check_search_data_set_item(item, {id: [r1.id, r2.id], uuid: [r1.uuid, r2.uuid], start_offset_seconds: nil, start_offset_seconds: nil})
      end
    end

  end

  describe 'sites' do

    it 'should raise an error for site ids less than 0' do
      # prepare
      r1 = create(:audio_recording)

      # run
      expect {
        the_search = SavedSearchStore.new(body_params: {site_id: -10})

        data_set = the_search.execute_query
      }.to raise_error(ArgumentError, 'SavedSearchStoreBody has errors: {"site_id":["must be greater than or equal to 1"]}.')

      # check

    end

    it 'should raise an error for site ids less than 1' do
      # prepare
      r1 = create(:audio_recording)

      # run
      expect {
        the_search = SavedSearchStore.new(body_params: {site_id: 0})

        data_set = the_search.execute_query
      }.to raise_error(ArgumentError, 'SavedSearchStoreBody has errors: {"site_id":["must be greater than or equal to 1"]}.')

      # check

    end

    it 'should get the matching audio recording using a single site id' do
      # prepare
      r1 = create(:audio_recording)
      r2 = create(:audio_recording)

      the_search = SavedSearchStore.new(body_params: {site_id: r2.site.id})


      # run
      data_set = the_search.execute_query

      # check
      data_set.items.size.should == 1

      data_set.items.each do |item|
        check_search_data_set_item(item, {id: [r2.id], uuid: [r2.uuid], start_offset_seconds: nil, start_offset_seconds: nil})
      end
    end

    it 'should get the matching audio recording using multiple site ids' do
      # prepare
      # 3 projects, 3 sites, 4 recordings
      p1 = create(:project)
      s1 = create(:site, projects: [p1])
      r1 = create(:audio_recording, site: s1)
      r2 = create(:audio_recording, site: p1.sites.first)
      r3 = create(:audio_recording)
      r4 = create(:audio_recording)

      the_search = SavedSearchStore.new(body_params: {site_id: s1.id})


      # run
      data_set = the_search.execute_query

      # check
      data_set.items.size.should == 2

      data_set.items.each do |item|
        check_search_data_set_item(item, {id: [r1.id, r2.id], uuid: [r1.uuid, r2.uuid], start_offset_seconds: nil, start_offset_seconds: nil})
      end
    end
  end
  describe 'date ranges' do
    it 'should restrict the results to date range of one day' do
      #prepare
      days_ago_2 = Time.current.advance({days: -2})
      days_ago_1 = Time.current.advance({days: -1})
      current_date = Time.current

      r1 = create(:audio_recording, recorded_date: days_ago_2)
      r2 = create(:audio_recording, recorded_date: days_ago_1)
      r3 = create(:audio_recording, recorded_date: current_date)

      the_search = SavedSearchStore.new(body_params: {date_start: days_ago_1.midnight, date_end: current_date})


      # run
      data_set = the_search.execute_query

      # check
      data_set.items.size.should == 1

      data_set.items.each do |item|
        check_search_data_set_item(item, {id: [r2.id], uuid: [r2.uuid], start_offset_seconds: nil, start_offset_seconds: nil})
      end

    end

    it 'should restrict the results to date range of one week' do
      #prepare
      weeks_ago_2 = Time.current.advance({weeks: -2})
      weeks_ago_2_minus_one_day = Time.current.advance({weeks: -2, seconds: 1})
      days_ago_1_midnight = Time.current.advance({days: -1}).midnight
      days_ago_1 = Time.current.advance({days: -1})
      current_date_midnight = Time.current.midnight
      current_date = Time.current

      u1 = create(:user)
      r1 = create(:audio_recording, user: u1, recorded_date: weeks_ago_2)
      r2 = create(:audio_recording, user: u1, recorded_date: weeks_ago_2_minus_one_day)
      r3 = create(:audio_recording, user: u1, recorded_date: days_ago_1_midnight)
      r4 = create(:audio_recording, user: u1, recorded_date: days_ago_1)
      r5 = create(:audio_recording, user: u1, recorded_date: current_date_midnight)
      r6 = create(:audio_recording, user: u1, recorded_date: current_date)

      the_search = SavedSearchStore.new(body_params: {date_start: days_ago_1, date_end: current_date})


      # run
      data_set = the_search.execute_query

      # check
      data_set.items.size.should == 2

      data_set.items.each do |item|
        check_search_data_set_item(item, {id: [r4.id, r5.id], uuid: [r4.uuid, r5.uuid], start_offset_seconds: nil, start_offset_seconds: nil})
      end

    end
  end

  describe 'time ranges ' do
    it 'should restrict the results to within the time range' do
      # prepare
      u1 = create(:user)
      r1 = create(:audio_recording, user: u1, recorded_date: Time.current.change({hour: 9, min: 40, sec: 50}), duration_seconds: 350)
      r2 = create(:audio_recording, user: u1, recorded_date: Time.current.change({hour: 9, min: 20, sec: 30}), duration_seconds: 350)
      r3 = create(:audio_recording, user: u1, recorded_date: Time.current.change({hour: 9, min: 1, sec: 0}), duration_seconds: 360)

      the_search = SavedSearchStore.new(body_params: {time_start: Time.current.change({hour: 9, min: 7, sec: 1}), time_end: Time.current.change({hour: 9, min: 39, sec: 49})})


      # run
      data_set = the_search.execute_query

      # check
      data_set.items.size.should == 1

      data_set.items.each do |item|
        check_search_data_set_item(item, {id: [r2.id], uuid: [r2.uuid], start_offset_seconds: nil, start_offset_seconds: nil})
      end
    end

    it 'should include audio recordings that partially match' do
      # prepare
      u1 = create(:user)
      r1 = create(:audio_recording, user: u1, recorded_date: Time.current.change({hour: 9, min: 40, sec: 50}), duration_seconds: 350)
      r2 = create(:audio_recording, user: u1, recorded_date: Time.current.change({hour: 9, min: 20, sec: 30}), duration_seconds: 350)
      r3 = create(:audio_recording, user: u1, recorded_date: Time.current.change({hour: 9, min: 1, sec: 0}), duration_seconds: 360)

      the_search = SavedSearchStore.new(body_params: {time_start: Time.current.change({hour: 9, min: 20, sec: 40}), time_end: Time.current.change({hour: 9, min: 20, sec: 55})})


      # run
      data_set = the_search.execute_query

      # check
      data_set.items.size.should == 1

      data_set.items.each do |item|
        check_search_data_set_item(item, {id: [r2.id], uuid: [r2.uuid], start_offset_seconds: nil, start_offset_seconds: nil})
      end
    end
  end

  describe 'tag array' do
    it 'should be an array if given' do
      # prepare

      #run
      expect {
        the_search = SavedSearchStore.new(body_params: {tags:'sdfsdf'})

        data_set = the_search.execute_query
      }.to raise_error(ArgumentError, 'SavedSearchStoreBody has errors: {"tags":["must be an array, given String with value sdfsdf."]}.')

      #check
    end

    it 'should only match audio recordings with events that have matching tags' do
      # prepare
      u1 = create(:user)

      r1 = create(:audio_recording, user: u1)
      r2 = create(:audio_recording, user: u1)
      r3 = create(:audio_recording, user: u1)

      t1 = create(:tag, text:'the first tag')
      t2 = create(:tag, text:'the second tag')

      e1 = create(:audio_event, audio_recording:r1)
      e2 = create(:audio_event, audio_recording:r2)
      e3 = create(:audio_event, audio_recording:r3)

      et1 = AudioEventTag.create(audio_event: e1, tag: t1)
      et2 = AudioEventTag.create(audio_event: e2, tag: t1)
      et3 = AudioEventTag.create(audio_event: e2, tag: t2)
      et4 = AudioEventTag.create(audio_event: e3, tag: t2)

      the_search = SavedSearchStore.new(body_params: {tags: %w(first)})


      # run
      data_set = the_search.execute_query

      # check
      data_set.items.size.should == 2

      data_set.items.each do |item|
        check_search_data_set_item(item, {id: [r1.id, r2.id], uuid: [r1.uuid, r2.uuid], start_offset_seconds: nil, start_offset_seconds: nil})
      end
    end

    it 'should not match audio recordings with audio events that do not match the tag' do
      # prepare
      u1 = create(:user)

      r1 = create(:audio_recording, user: u1)
      r2 = create(:audio_recording, user: u1)
      r3 = create(:audio_recording, user: u1)

      t1 = create(:tag, text:'the first tag')
      t2 = create(:tag, text:'the second tag')

      e1 = create(:audio_event, audio_recording:r1)
      e2 = create(:audio_event, audio_recording:r2)
      e3 = create(:audio_event, audio_recording:r3)

      et1 = AudioEventTag.create(audio_event: e1, tag: t1)
      et2 = AudioEventTag.create(audio_event: e2, tag: t1)
      et3 = AudioEventTag.create(audio_event: e2, tag: t2)
      et4 = AudioEventTag.create(audio_event: e3, tag: t2)

      the_search = SavedSearchStore.new(body_params: {tags: %w(first1)})


      # run
      data_set = the_search.execute_query

      # check
      data_set.items.size.should == 0
    end

  end

  #it "should be a complicated search" do
  #
  #  the_search = SavedSearchStore.new(:body_params => {
  #      :project_ids => [1],
  #      :site_ids => [2],
  #      :audio_recording_ids => [3],
  #      :date_start => Time.zone.parse('2012-11-21 10:40:00'), :date_end => Time.zone.parse('2012-11-21 15:30'),
  #      time_start: Time.current.change({hour: 0, min: 10, sec: 0}),
  #      time_end: Time.current.change({hour: 8, min: 40, sec: 0}),
  #      # tags is just a simple array for now
  #      :tags => %w(koala crow)
  #  })
  #
  #
  #  data_set = the_search.execute_query
  #
  #  #assert_equal 1, data_set.items[0].audio_recording_id
  #end
end