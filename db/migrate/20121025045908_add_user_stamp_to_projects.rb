class AddUserStampToProjects < ActiveRecord::Migration
  def change
    change_table :projects do |t|
      t.userstamps include_deleted_by = true
      end
  end
end
