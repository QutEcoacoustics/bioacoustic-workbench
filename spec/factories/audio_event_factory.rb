require 'faker'

FactoryGirl.define do
  factory :audio_event do |f|
    f.start_time_seconds 5.36
    f.low_frequency_hertz 1023
    f.end_time_seconds 12.75
    f.high_frequency_hertz 7500
    f.audio_recording { |ar| ar.association(:audio_recording) }
  end
end