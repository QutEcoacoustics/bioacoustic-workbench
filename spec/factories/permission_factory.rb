require 'faker'

FactoryGirl.define do
  factory :permission do
    level :none



    association :creator_id, :factory => :user
    association :user

    factory :project_permission do
      association :permissionable, factory: :project
    end
  end
end