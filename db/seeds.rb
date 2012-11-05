# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

# Super user setup
dummy = User.create({display_name: "admin"})
dummy.creator_id = dummy.id
dummy.updater_id = dummy.id
dummy.save



case Rails.env
when "development"
   p1 = Project.create({description: "I'm a project, I'm a project, I'm a project!", name: "test proj", notes:{}, urn:"http://localhost:3000/projects/test_proj"})
   p1.creator_id = p1.updater_id = dummy.id
  p1.save

   p2 = Project.create({description: "I'm another project, I'm another project, I'm another project!", name: "test proj another", notes:{}, urn:"http://localhost:3000/projects/test_proj_another"})
   p2.creator_id = p2.updater_id = dummy.id
  p2.save

   p3 = Project.create({description: "I'm a project an i'm ok - ish...", name: "test proj-ish", notes:{}, urn:"http://localhost:3000/projects/test_proj-ish"})
   p3.creator_id = p3.updater_id = dummy.id
  p3.save
   
when "production"

when "test"
  # these seeds should be put in the fixtures folder
end