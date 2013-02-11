require 'faker'

FactoryGirl.define do
  factory :audio_recording do |f|

    f.recorded_date 7.days.ago
    f.duration_seconds 350
    f.sample_rate_hertz 22050
    f.channels 1
    f.bit_rate_bps 192000
    f.media_type 'audio/mpeg'
    f.data_length_bytes 8400000
    f.file_hash "SHA 256::asdfdsa6fa3fa56fdsa"
    f.status {[:new, :to_check, :ready, :corrupt, :ignore].sample}

    f.association :site
    f.association :uploader, factory: :user
    f.association :creator, factory: :user
  end
end