class CreateProjects < ActiveRecord::Migration
  def change
    create_table :projects do |t|
      t.string :name
      t.text :description
      t.string :urn
      t.text :notes

      t.timestamps
    end
  end
end
