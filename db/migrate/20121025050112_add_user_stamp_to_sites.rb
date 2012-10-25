class AddUserStampToSites < ActiveRecord::Migration
  def change
    change_table :sites do |t|
      t.userstamps
      end
  end
end
