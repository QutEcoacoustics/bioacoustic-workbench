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
   
   
when "production"

when "test"
  # these seeds should be put in the fixtures folder
end