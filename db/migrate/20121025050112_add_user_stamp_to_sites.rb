class AddUserStampToSites < ActiveRecord::Migration
  def change
    change_table :sites do |t|
      t.userstamps include_deleted_by = true
      end
  end
end
