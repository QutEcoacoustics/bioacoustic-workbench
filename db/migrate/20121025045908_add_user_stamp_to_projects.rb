class AddUserStampToProjects < ActiveRecord::Migration
  def change
    change_table :projects do |t|
      t.userstamps
      end
  end
end
