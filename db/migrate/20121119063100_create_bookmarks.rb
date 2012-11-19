class CreateBookmarks < ActiveRecord::Migration
  def change
    create_table :bookmarks do |t|
      t.references :audio_recording, :null => false
      t.decimal :offset, :null => false, :scale => 6
      t.string :name
      t.text :notes

      t.timestamps
      t.userstamps

    end
    add_index :bookmarks, :audio_recording_id
    add_index :bookmarks, :creator_id
  end
end
