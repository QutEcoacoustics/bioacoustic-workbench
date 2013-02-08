class AddLoggedInToPermissions < ActiveRecord::Migration
  def change
    add_column :permissions, :logged_in, :boolean, null: false, default: true
  end
end
