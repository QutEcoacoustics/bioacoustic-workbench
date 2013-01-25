require 'faker'

FactoryGirl.define do
  factory :user do |f|

    user_name { Faker::Internet.user_name}
    display_name { Faker::Name.name}
    email { Faker::Internet.email}
    admin false
    password {Faker::Lorem.words(6).join(' ')}
  end
end