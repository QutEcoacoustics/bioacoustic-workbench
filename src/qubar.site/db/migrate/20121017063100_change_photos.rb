class AddPolyphormicToPhotos < ActiveRecord::Migration
  def up
    change_table :photos do |t|
      t.references :imageable, :polymorphic => true
	end
  end
  
  def down
    change_table :photos do |t|
      t.remove_references :imageable, :polymorphic => true
	end
  end
end