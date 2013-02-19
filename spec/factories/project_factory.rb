require 'faker'

FactoryGirl.define do
  factory :project do
   description { Faker::Lorem.sentences(2) }
   name { Faker::Name.title }
   latitude Random.rand(180) - 90
   longitude Random.rand(360) - 180

   sequence(:urn) {|n| "urn:project:ecosounds.org/project/#{n}" }

   notes { { Faker::Lorem.word => Faker::Lorem.paragraph } }

   association :creator, factory: :user
  end
end