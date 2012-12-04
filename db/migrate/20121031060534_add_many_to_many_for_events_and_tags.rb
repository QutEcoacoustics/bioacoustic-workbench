class AddManyToManyForEventsAndTags < ActiveRecord::Migration
  def change
    create_table :audio_event_tags, :id => false do |t|
      t.integer :audio_event_id, :null => false
      t.integer :tag_id, :null => false

      t.timestamps
      t.userstamps
    end
    add_index :audio_event_tags,
              [:audio_event_id, :tag_id, :creator_id],
              :unique => true, :name => 'hack_index_for_nested_attrs'
  end
end
