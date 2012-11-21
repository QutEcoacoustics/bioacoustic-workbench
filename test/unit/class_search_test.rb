require 'test_helper'

class ClassSearchTest < ActiveSupport::TestCase
   test "an empty search query" do

     the_search = Search.new( { } )

     data_set = the_search.execute_query

     assert_equal 6, data_set.items.size
     assert data_set.items.include?('1bd0d668-1471-4396-adc3-09ccd8fe949a')

   end

   test "a single project" do

     the_search = Search.new( { :body_params => { :project_ids => [ 1 ] } } )

     data_set = the_search.execute_query

     #assert_equal 1, data_set.items[0].audio_recording_id
     puts data_set.query.to_sql

   end

   test "a single site" do

     the_search = Search.new( { :body_params => { :site_ids => [ 1 ] } } )

     data_set = the_search.execute_query

     #assert_equal 1, data_set.items[0].audio_recording_id
     puts data_set.query.to_sql

   end

   test "a single recording" do

     the_search = Search.new( { :body_params => { :audio_recording_ids => [ 1 ] } } )

     data_set = the_search.execute_query

     #assert_equal 1, data_set.items[0].audio_recording_id
     puts data_set.query.to_sql

   end

   test "a complicated search" do

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
     puts data_set.query.to_sql
     puts data_set.items
   end
end
