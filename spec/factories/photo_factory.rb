require 'faker'

FactoryGirl.define do
  factory :photo do
    copyright { "Copyright of #{Faker::Name.name} (#{Faker::Name.title})"}

    uri { Faker::Internet.url() + '/' + (Faker::Lorem::words(2).join('_').downcase) + '.jpg' }

    description { Faker::Lorem.paragraphs(2)}


    factory :site_photo do
      association :imageable, factory: :site
    end


    factory :project_photo do
      association :imageable, factory: :project
    end
  end
end