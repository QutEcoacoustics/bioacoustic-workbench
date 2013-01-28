class CreateTags < ActiveRecord::Migration
  def change
    create_table :tags do |t|
      t.string :text
      t.boolean :is_taxanomic, :null => false, :default => false

      t.string :type_of_tag

      t.timestamps
      t.userstamps

      # disabled due to updated specs 28/01/13, By Anthony
      # include_deleted_by = true
    end
    add_index :tags, :text, :unique => true
  end
end
