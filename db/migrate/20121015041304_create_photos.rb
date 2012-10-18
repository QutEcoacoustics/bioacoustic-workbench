class CreatePhotos < ActiveRecord::Migration
  def change
    create_table :photos do |t|
      t.string :uri
      t.text :copyright

      t.timestamps
    end
  end
end
