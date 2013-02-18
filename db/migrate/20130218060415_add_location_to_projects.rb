class AddLocationToProjects < ActiveRecord::Migration
  def change
    add_column :projects, :latitude, :decimal
    add_column :projects, :longitude, :decimal
  end
end
