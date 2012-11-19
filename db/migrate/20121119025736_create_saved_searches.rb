class CreateSavedSearches < ActiveRecord::Migration
  def change
    create_table :saved_searches do |t|
      t.string :name
      t.text :search_object, :null => false

      t.timestamps
      t.userstamps
    end
    add_index :saved_searches, [:creator_id, :name, :search_object], :unique => true
  end

end
