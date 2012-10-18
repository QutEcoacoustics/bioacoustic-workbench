class CreateSites < ActiveRecord::Migration
  def change
    create_table :sites do |t|
      t.string :name
      t.decimal :latitude
      t.decimal :longitude
      t.text :notes

      t.timestamps
    end
  end
end
