require 'faker'

FactoryGirl.define do
  factory :saved_search_base, class: SavedSearch do


    name { 'My custom saved search (' + Faker::Lorem.sentence() + ')'}
    search_object { '{}'} # an empty search

    association :creator_id, factory: :user


    factory :saved_search do
      association :owner_id, factory: :user
    end

    end
end