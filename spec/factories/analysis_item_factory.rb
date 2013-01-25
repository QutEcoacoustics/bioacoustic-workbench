require 'faker'

FactoryGirl.define do
  factory :analysis_item do |f|

    f.worker_started_utc { Random.rand(30).minutes.ago }
    f.offset_end_seconds { Random.rand(360)  + 360 }
    f.offset_start_seconds { Random.rand(360) }
    f.status {[:ready, :running, :complete, :error].sample}


    f.association :analysis_job
    f.association :audio_recording
  end
end