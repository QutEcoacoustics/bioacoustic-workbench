require_relative "./development_seeds"

# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).

def create_user(name_to_check, details)
  puts "Checking for #{name_to_check} user..."
  admin_user = User.where(:display_name => name_to_check).first

  if admin_user.blank?
    admin_user = User.create(details)
    admin_user.creator_id = admin_user.id
    admin_user.updater_id = admin_user.id
    admin_user.save!
    puts "... #{name_to_check} user created."
  else
    puts "... #{name_to_check} user already exists."
  end
end

# Super user setup - for any environment
create_user('admin', {display_name: 'admin', email: 'example+admin@example.com', password: 'admin_password' })
create_user('harvester', {display_name: 'harvester', email: 'example+harvester@example.com', password: 'harvester_password' })

admin_user = User.where(:display_name => 'admin').first

puts "BAW build :: Adding additional environment ('#{Rails.env}') specific data to database..."
case Rails.env
  when "development"
    run_dev_seeds admin_user.id
  when "production"

  when "test"
    # these seeds should be put in the fixtures folder
    run_dev_seeds admin_user.id
end