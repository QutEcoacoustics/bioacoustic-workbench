class AddManyToManyForEventsAndTags < ActiveRecord::Migration
  def change
    create_table :audio_event_tags, :id => false do |t|
      t.integer :audio_event_id, :null => false
      t.integer :tag_id, :null => false

      t.timestamps
      t.userstamps
    end
    add_index :audio_event_tags,
              [:audio_event_id, :tag_id],
              :unique => true
  end
end
