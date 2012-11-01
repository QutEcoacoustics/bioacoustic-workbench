class CreatePermissions < ActiveRecord::Migration
  def change
    create_table :permissions do |t|
      t.references :user
      t.string :level, :null => false

      t.references :permissionable, :polymorphic => true

      t.timestamps
      t.userstamps
    end
    add_index :permissions, :user_id
  end
end
