require 'faker'

FactoryGirl.define do
  factory :project do |f|
    f.description {Faker::Lorem.sentences(2)}
    f.name {Faker::Name.title}
    f.urn {'urn:organisation:project'}
    f.notes { {Faker::Lorem.word => Faker::Lorem.paragraph} }
  end
end