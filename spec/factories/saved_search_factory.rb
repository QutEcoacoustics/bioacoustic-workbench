require 'faker'

FactoryGirl.define do
  factory :saved_search_base, class: SavedSearch do

    sequence(:name) {|n|
      'My custom saved search ('+Faker::Lorem.words(2).join(' ') + "_#{n})"
    }

    search_object { '{}'} # an empty search

    association :creator, factory: :user

    factory :saved_search do
      association :owner, factory: :user
    end

    end
end