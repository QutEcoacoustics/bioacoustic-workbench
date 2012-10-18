class AddDescriptionToPhotos < ActiveRecord::Migration
  def up
    change_table :photos do |t|
	  t.change :copyright, :string
	  t.text :description
    end
  end
  def down
    change_table :photos do |t|
	  t.change :copyright, :text
	  t.remove :description
    end
  end
end