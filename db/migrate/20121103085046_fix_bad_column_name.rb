class FixBadColumnName < ActiveRecord::Migration
  def change
    rename_column :audio_recordings, :hash, :file_hash
  end
end
