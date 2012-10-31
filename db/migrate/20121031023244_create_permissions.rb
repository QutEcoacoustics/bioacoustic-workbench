class CreatePermissions < ActiveRecord::Migration
  def change
    create_table :permissions do |t|
      t.references :user
      t.string :level

      t.timestamps
      t.userstamps
    end
    add_index :permissions, :user_id
  end
end
