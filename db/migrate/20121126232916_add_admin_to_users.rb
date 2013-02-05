class AddAdminToUsers < ActiveRecord::Migration
  def change
    # Option 2 from https://github.com/plataformatec/devise/wiki/How-To:-Add-an-Admin-role
    add_column :users, :admin, :boolean, :default => false, :null => false
  end
end
