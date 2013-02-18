class AddNotesAndRetiredToTags < ActiveRecord::Migration
  def change
    add_column :tags, :retired, :boolean
    add_column :tags, :notes, :text
  end
end
