require 'faker'

FactoryGirl.define do
  factory :project do
   description { Faker::Lorem.sentences(2) }
   name { Faker::Name.title }

   sequence(:urn) {|n| "urn:project:ecosounds.org/project/#{n}" }

   notes { { Faker::Lorem.word => Faker::Lorem.paragraph } }
  end
end