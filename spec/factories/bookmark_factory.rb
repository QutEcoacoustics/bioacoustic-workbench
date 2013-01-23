require 'faker'

FactoryGirl.define do
  factory :bookmark do
    name {Faker::Lorem.words(2).join(' ')}
    offset_seconds {Random.rand(360.0)}
    notes { { 'my favourite' => Faker::Lorem.paragraph} }

    association :creator_id, :factory => :user
    audio_recording
  end
end