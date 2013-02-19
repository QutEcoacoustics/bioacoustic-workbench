require 'faker'

FactoryGirl.define do

  sequence(:user_counter)

  factory :user do
    user_name { Faker::Internet.user_name + generate(:user_counter).to_s }
    display_name { Faker::Name.name + generate(:user_counter).to_s}
    email { Faker::Internet.email + generate(:user_counter).to_s}
    admin false
    password {Faker::Lorem.words(6).join(' ')}
  end
end