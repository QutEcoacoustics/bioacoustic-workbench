class AddSeperateUserOwnerFieldToSavedSearches < ActiveRecord::Migration
  def change
    add_column :saved_searches, :owner_id, :integer
    add_index :saved_searches, :owner_id
  end
end
