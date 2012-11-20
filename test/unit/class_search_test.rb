require 'test_helper'

class ClassSearchTest < ActiveSupport::TestCase
   test "an empty search query" do

     the_search = Search.new( { :body_params => { :project_ids => [ 1 ] } } )

     data_set = the_search.execute_query

     assert_equal 1, data_set.items[0].audio_recording_id
     puts data_set

   end
end
