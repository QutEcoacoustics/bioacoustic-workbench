require 'faker'

FactoryGirl.define do
  factory :site do |f|
    f.name {Faker::Name.title}
    f.latitude Random.rand(180) - 90
    f.longitude Random.rand(360) - 180
    f.notes { {Faker::Lorem.word => Faker::Lorem.paragraph} }

    #after(:create) {|site|      factory(:project, :site => site)    }
    f.projects {|projects| [projects.association(:project)]}
  end
end