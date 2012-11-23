require_relative "./development_seeds"

# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).

# Super user setup - for any environment
admin_user = User.where(:display_name => 'admin').first

if admin_user.blank?
  admin_user = User.create({display_name: "admin"})
  admin_user.creator_id = admin_user.id
  admin_user.updater_id = admin_user.id
  admin_user.save!
end

puts "BAW build :: Adding additional environment ('#{Rails.env}') specific data to database..."
case Rails.env
  when "development"
    run_dev_seeds admin_user.id
  when "production"

  when "test"
    # these seeds should be put in the fixtures folder
    run_dev_seeds admin_user.id
end