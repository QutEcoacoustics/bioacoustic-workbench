require 'faker'

FactoryGirl.define do
  factory :saved_search do |f|

    f.name { 'My custom saved search (' + Faker::Lorem.sentence() + ')'}
    f.search_object { '{}'} # an empty search

    f.association :creator_id, :factory => :user
  end


end