require 'faker'
require_relative '../support/analysis_script_helper.rb'



FactoryGirl.define do
  factory :analysis_script do |f|

    sequence(:display_name) {|n|
      Faker::Lorem.words(2).join(' ') + "_#{n}"
    }

    s = Shared::shared_properties
    #f.display_name s[:display_name]
    f.name nil # very important that that stays nil #s[:name]
    f.extra_data s[:extra_data]
    f.settings s[:settings]
    f.description s[:description]
    f.version s[:version]

    f.notes ({ notes: 'something' })

    f.verified true


    f.association :creator_id, factory: :user

    factory :analysis_script_unverified do
      verified false
    end
  end
end