class CreateAudioRecordings < ActiveRecord::Migration
  def change
    #noinspection SpellCheckingInspection
    create_table :audio_recordings do |t|
      t.string :uuid, :null => false, :limit => 36
      t.integer :uploader_id, :null => false
      t.datetime :recorded_date, :null => false
      t.references :site, :null => false
      t.decimal :duration_seconds, :null => false, :scale => 6
      t.integer :sample_rate_hertz
      t.integer :channels
      t.integer :bit_rate_bps
      t.string :media_type, :null => false
      t.integer :data_length_bytes, :null => false

      # Allow up to a 512 byte hash, + 12 descriptor characters
      # e.g. SHA2 - 512::szn gkfavjkajkbgajkbavkbvadbva ds albfeaiuewr3p2u-0932u0-=5...
      t.string :hash, :limit => 512 + 12, :null => false
      t.string :status
      t.text :notes

      t.timestamps
      t.userstamps include_deleted_by = true
    end
    add_index :audio_recordings, :uploader_id
    add_index :audio_recordings, :site_id
    add_index :audio_recordings, :uuid, :unique => true
  end
end
