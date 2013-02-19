require 'faker'

FactoryGirl.define do

  sequence(:tag_counter)

  factory :tag do |f|

    f.is_taxanomic true
    f.text {Faker::Lorem.word + f.generate(:tag_counter).to_s}
    f.type_of_tag {[:common_name, :species_name, :looks_like, :sounds_like].sample}
    f.retired false
    f.notes { { Faker::Lorem.word => Faker::Lorem.paragraph } }

    f.association :creator, factory: :user

  end
end