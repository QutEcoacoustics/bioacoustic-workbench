require 'faker'
require_relative '../support/analysis_script_helper.rb'


FactoryGirl.define do
  factory :analysis_job do |f|

    sequence(:script_name) {|n|
      Faker::Lorem.words(2).join('_') + "_#{n}"
    }

    sequence(:script_display_name) {|n|
      Faker::Lorem.words(2).join(' ') + "_#{n}"
    }

    f.description { Faker::Lorem.paragraphs(3) }
    f.name { Faker::Internet.user_name + '\'s job' }
    f.process_new false

    # uses function from analysis_script_factory to generate these
    s = Shared::shared_properties
    #f.script_display_name s[:display_name]
    #f.script_name s[:name]
    f.script_extra_data s[:extra_data]
    f.script_settings s[:settings]
    f.script_description s[:description]
    f.script_version s[:version]

    #f.worker_started_utc Random.rand(30).minutes.ago
    #f.offset_end_seconds Random.rand(360)
    #f.offset_start_seconds Random.rand(360)
    #f.status :ready


    f.association :saved_search
    f.association :creator_id, :factory => :user


    factory :analysis_job_onrunning do
      process_new true
    end

  end


end