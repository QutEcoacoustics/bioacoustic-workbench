require 'faker'

FactoryGirl.define do
  factory :tag do |f|

    f.is_taxanomic true
    f.text {Faker::Lorem.word}
    f.type_of_tag {[:common_name, :species_name, :looks_like, :sounds_like].sample}


    f.association :creator_id, :factory => :user

  end
end