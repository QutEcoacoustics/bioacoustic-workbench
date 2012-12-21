require_relative "./development_seeds"

# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).

def create_user(details)
  puts "Checking for #{details[:user_name]} user..."

  db_user = User.where(:user_name => details[:user_name]).first

  if db_user.blank?
    db_user = User.create(details)
    db_user.creator_id = db_user.id
    db_user.updater_id = db_user.id

    db_user.skip_user_name_exclusion_list = true

    db_user.save!

    db_user.skip_user_name_exclusion_list = false

    puts "... #{details[:user_name]} user created."
  else
    puts "... #{details[:user_name]} user already exists."
  end
end

# Super user setup - for any environment
create_user({user_name: 'admin', display_name: 'Administrator', email: 'example+admin@example.com', password: 'admin_password', admin: true })
create_user({user_name: 'harvester', display_name: 'Harvester', email: 'example+harvester@example.com', password: 'harvester_password' })
create_user({user_name: 'analysis_runner', display_name: 'Analysis Runner', email: 'example+analysis_runner@example.com', password: 'analysis_runner_password' })

admin_user = User.where(:user_name => 'admin').first

puts "BAW build :: Adding additional environment ('#{Rails.env}') specific data to database..."
case Rails.env
  when "development"
    run_dev_seeds admin_user.id
  when "production"

  when "test"
    # these seeds should be put in the fixtures folder
    run_dev_seeds admin_user.id
end