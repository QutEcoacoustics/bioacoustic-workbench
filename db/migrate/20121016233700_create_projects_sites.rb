class CreateProjectsSites < ActiveRecord::Migration
  def change
    create_table :project_sites, :id => false do |t|
	  t.integer :project_id
      t.integer :site_id
	  
      t.timestamps
    end
  end
end