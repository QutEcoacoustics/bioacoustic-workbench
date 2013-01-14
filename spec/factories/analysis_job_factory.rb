require 'faker'

FactoryGirl.define do
  factory :analysis_job do |f|

    f.description { Faker::Lorem.paragraphs(3)}
    f.name {Faker::Internet.user_name + '\'s job'}
    f.process_new = false

    # todo: use function from analysis_script to generate these
    f.script_name
    f.script_display_name {Faker::Internet.user_name + '\'s job'}
    f.script_description {Faker::Lorem.paragraphs(6)}
    f.script_extra_data
    f.script_settings
    f.script_version

    #f.worker_started_utc Random.rand(30).minutes.ago
    #f.offset_end_seconds Random.rand(360)
    #f.offset_start_seconds Random.rand(360)
    #f.status :ready


    f.association :saved_search
    f.association :creator_id, :factory => :user


    factory :analysis_job_onrunning do
      process_new = true
    end

  end



end