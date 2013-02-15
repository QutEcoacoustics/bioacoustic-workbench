class AddIsFakeEmailToUsers < ActiveRecord::Migration
  def change
    add_column :users, :is_fake_email, :boolean
  end
end
