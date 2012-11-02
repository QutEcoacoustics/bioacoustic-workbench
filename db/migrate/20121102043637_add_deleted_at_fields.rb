class AddDeletedAtFields < ActiveRecord::Migration
  def change
    change_table :permissions do |t|
      t.datetime :deleted_at
    end
    change_table :projects do |t|
      t.datetime :deleted_at
    end
    change_table :sites do |t|
      t.datetime :deleted_at
    end
    change_table :audio_recordings do |t|
      t.datetime :deleted_at
    end
    change_table :audio_events do |t|
      t.datetime :deleted_at
    end
    change_table :tags do |t|
      t.datetime :deleted_at
    end
  end
end
