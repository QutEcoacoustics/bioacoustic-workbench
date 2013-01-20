class BookmarkChangeOffsetName < ActiveRecord::Migration
  def change
    rename_column :bookmarks, :offset, :offset_seconds
  end
end
