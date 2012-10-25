class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :display_name

      t.timestamps
      t.userstamps
    end
  end
end
