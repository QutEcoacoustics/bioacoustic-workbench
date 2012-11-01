class CreateAudioEvents < ActiveRecord::Migration
  def change
    create_table :audio_events do |t|
      t.references :audio_recording, :null => false
      t.decimal :start_time_seconds, :null => false, :scale => 6
      t.decimal :end_time_seconds, :scale => 6
      t.decimal :low_frequency_hertz, :null => false, :scale => 6
      t.decimal :high_frequency_hertz, :scale => 6
      t.boolean :is_reference, :null => false, :default => false

      t.timestamps
      t.userstamps include_deleted_by = true
    end
    add_index :audio_events, :audio_recording_id
  end
end
