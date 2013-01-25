require 'faker'

FactoryGirl.define do
  factory :progress do
    offset_list {
      ([
          [0.0, 33.26],
          [60, 360],
          [720, 792.3654],
          [1600, 1632],
          [1750, 1894],
          [2400, 2520],
      ]).to_json
    }

    start_offset_seconds { Random.rand(20) }
    end_offset_seconds { Random.rand(1000) + 2500  }

    activity { ['annotating', 'listening', 'checklisting' ].sample }

    association :creator_id, :factory => :user

    association :saved_search
    association :audio_recording


  end
end