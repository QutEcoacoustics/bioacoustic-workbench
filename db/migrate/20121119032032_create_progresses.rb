class CreateProgresses < ActiveRecord::Migration
  def change
    create_table :progresses do |t|
      t.references :saved_search, :null => false
      t.references :audio_recording, :null => false

      t.string :activity, :null => false
      t.decimal :start_offset_seconds, :null => false, :scale => 6
      t.decimal :end_offset_seconds, :null => false, :scale => 6

      t.binary :offset_list, :null => false

      t.timestamps
      t.userstamps
    end
    add_index :progresses, :saved_search_id
    add_index :progresses, :audio_recording_id
    add_index :progresses,
              [:creator_id, :activity, :saved_search_id, :audio_recording_id,
               :start_offset_seconds, :end_offset_seconds],
              :unique => true, :name => 'six_column_uniqueness_key'
  end
end
