require 'faker'

FactoryGirl.define do
  factory :permission do
    level {[:owner, :writer, :reader, :none].sample}#:none
    logged_in true


    association :creator_id, factory: :user
    association :user

    factory :project_permission do
      association :permissionable, factory: :project
    end
  end
end