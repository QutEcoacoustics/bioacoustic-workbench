require 'faker'

FactoryGirl.define do

  sequence(:counter)

  factory :user do
    user_name { Faker::Internet.user_name + generate(:counter).to_s }
    display_name { Faker::Name.name + generate(:counter).to_s}
    email { Faker::Internet.email + generate(:counter).to_s}
    admin false
    password {Faker::Lorem.words(6).join(' ')}
  end
end