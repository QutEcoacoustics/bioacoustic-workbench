require 'spec_helper'

describe SavedSearch do
  include Shared

  it "should be a complicated search" do

    the_search = Search.new( { :body_params => {
        :project_ids => [ 1 ],
        :site_ids => [ 2 ],
        :audio_recording_ids => [ 3 ],
        :date_start => Time.zone.parse('2012-11-21'), :date_end => Time.zone.parse('2012-11-21'),
        :time_ranges => [[0,10],[40,85]],
        # tags is just a simple array for now
        :tags => %w(koala crow)
    } } )

    data_set = the_search.execute_query

    #assert_equal 1, data_set.items[0].audio_recording_id

  end

  describe "empty search" do
    it 'should return all available recordings' do
      # prepare
      r1 = create(:audio_recording)
      r2 = create(:audio_recording)
      r3 = create(:audio_recording)

      the_search = Search.new({})

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

      the_search = Search.new({})

      # run
      data_set = the_search.execute_query

      # check
      data_set.items.size.should == 0
    end
  end

  describe 'matches audio recording ids' do
    it 'should return only one audio recording using id' do
      # prepare
      r1 = create(:audio_recording)
      r2 = create(:audio_recording)
      r3 = create(:audio_recording)

      the_search = Search.new({body_params: {audio_recording_ids: [r1.id]}})

      # run
      data_set = the_search.execute_query

      # check
      data_set.items.size.should == 1

      data_set.items.each do |item|
        check_search_data_set_item(item, {id: [r1.id], uuid:[r1.uuid], start_offset_seconds:nil, start_offset_seconds:nil})
      end
    end

    it 'should return only one audio recording using uuid' do
      # prepare
      r1 = create(:audio_recording)
      r2 = create(:audio_recording)
      r3 = create(:audio_recording)

      the_search = Search.new({body_params: {audio_recording_uuids: [r1.uuid]}})

      # run
      data_set = the_search.execute_query

      # check
      data_set.items.size.should == 1

      data_set.items.each do |item|
        check_search_data_set_item(item, {id: [r1.id], uuid:[r1.uuid], start_offset_seconds:nil, start_offset_seconds:nil})
      end
    end
  end
  describe 'projects' do
    it 'should raise an error for project ids less than 0' do
      # prepare
      r1 = create(:audio_recording)

      # run
      expect {
        the_search = Search.new({body_params: {project_ids: [1, -10]}})
      }.to raise_error(ArgumentError, 'Invalid ids given: [-10]')

      # check

    end

    it 'should raise an error for project ids less than 1' do
      # prepare
      r1 = create(:audio_recording)

      # run
      expect {
        the_search = Search.new({body_params: {project_ids: [1, 0]}})
      }.to raise_error(ArgumentError, 'Invalid ids given: [0]')

      # check

    end

    it 'should get the matching audio recording using a single project id' do
      # prepare
      r1 = create(:audio_recording)
      r2 = create(:audio_recording)

      the_search = Search.new({body_params: {project_ids: r2.site.projects.collect{|p| p.id} }})

      # run
      data_set = the_search.execute_query

      # check

      data_set.items.size.should == 1

      data_set.items.each do |item|
        check_search_data_set_item(item, {id: [r2.id], uuid:[r2.uuid], start_offset_seconds:nil, start_offset_seconds:nil})
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

      the_search = Search.new({body_params: {project_ids: r3.site.projects.collect{|p| p.id}.concat([p1.id]) }})

      # run
      data_set = the_search.execute_query

      # check
      data_set.items.size.should == 3

      data_set.items.each do |item|
        check_search_data_set_item(item, {id: [r1.id, r2.id, r3.id], uuid:[r1.uuid,r2.uuid,r3.uuid], start_offset_seconds:nil, start_offset_seconds:nil})
      end
    end

  end

  describe 'sites' do

    it 'should raise an error for site ids less than 0' do
      # prepare
      r1 = create(:audio_recording)

      # run
      expect {
        the_search = Search.new({body_params: {site_ids: [1, -10]}})
      }.to raise_error(ArgumentError, 'Invalid ids given: [-10]')

      # check

    end

    it 'should raise an error for site ids less than 1' do
      # prepare
      r1 = create(:audio_recording)

      # run
      expect {
        the_search = Search.new({body_params: {site_ids: [1, 0]}})
      }.to raise_error(ArgumentError, 'Invalid ids given: [0]')

      # check

    end

    it 'should get the matching audio recording using a single site id' do
      # prepare
      r1 = create(:audio_recording)
      r2 = create(:audio_recording)

      the_search = Search.new({body_params: {site_ids: [r2.site.id]}})

      # run
      data_set = the_search.execute_query

      # check
      data_set.items.size.should == 1

      data_set.items.each do |item|
        check_search_data_set_item(item, {id: [r2.id], uuid:[r2.uuid], start_offset_seconds:nil, start_offset_seconds:nil})
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

      the_search = Search.new({body_params: {site_ids: [r1.site.id, r4.site.id] }})

      # run
      data_set = the_search.execute_query

      # check
      data_set.items.size.should == 3

      data_set.items.each do |item|
        check_search_data_set_item(item, {id: [r1.id, r2.id, r4.id], uuid:[r1.uuid,r2.uuid,r4.uuid], start_offset_seconds:nil, start_offset_seconds:nil})
      end
    end
  end
  describe 'date ranges' do
    it 'should restrict the results to date range of one day' do
      #prepare
      current_date = DateTime.now
      days_ago_2 = DateTime.now.advance({days: -2})
      days_ago_1 = DateTime.now.advance({days: -1})

      r1 = create(:audio_recording, recorded_date: days_ago_2)
      r2 = create(:audio_recording, recorded_date: days_ago_1)
      r3 = create(:audio_recording, recorded_date: current_date)

      the_search = Search.new({body_params: {date_start: days_ago_1, date_end: days_ago_1 }})

      # run
      puts [r1.inspect, r2.inspect, r3.inspect]
      data_set = the_search.execute_query

      # check
      data_set.items.size.should == 1

      data_set.items.each do |item|
        check_search_data_set_item(item, {id: [r2.id], uuid:[r2.uuid], start_offset_seconds:nil, start_offset_seconds:nil})
      end

    end

    it 'should restrict the results to date range of one week' do
      #prepare
      weeks_ago_2 = DateTime.now.advance({weeks: -2})
      days_ago_1 = DateTime.now.advance({days: -1})
      current_date = DateTime.now
      r1 = create(:audio_recording, recorded_date: weeks_ago_2)
      r2 = create(:audio_recording, recorded_date: days_ago_1)
      r3 = create(:audio_recording, recorded_date: current_date)

      the_search = Search.new({body_params: {date_start: days_ago_1, date_end: current_date }})

      # run
      puts [r1.inspect, r2.inspect, r3.inspect]
      data_set = the_search.execute_query

      # check
      data_set.items.size.should == 2

      data_set.items.each do |item|
        check_search_data_set_item(item, {id: [r2.id, r3.id], uuid:[r2.uuid, r3.uuid], start_offset_seconds:nil, start_offset_seconds:nil})
      end

    end
  end

  describe 'time ranges 'do
    it 'should restrict the results to within the time range' do
      # prepare
      r1 = create(:audio_recording, recorded_date: DateTime.now.change({hour: 10, min:0, sec: 30}))
      r2 = create(:audio_recording, recorded_date: DateTime.now.change({hour: 9, min:0, sec: 30}))
      r3 = create(:audio_recording, recorded_date: DateTime.now.change({hour: 8, min:59, sec: 30}))

      the_search = Search.new({body_params: {time_ranges: [[DateTime.now.change({hour: 9, min:0, sec: 0}), DateTime.now.change({hour: 10, min:0, sec: 0})]] }})

      # run
      puts [r1.inspect, r2.inspect, r3.inspect, the_search]
      data_set = the_search.execute_query

      # check
      data_set.items.size.should == 1

      data_set.items.each do |item|
        check_search_data_set_item(item, {id: [r2.id], uuid:[r2.uuid], start_offset_seconds:nil, start_offset_seconds:nil})
      end

    end
  end
end