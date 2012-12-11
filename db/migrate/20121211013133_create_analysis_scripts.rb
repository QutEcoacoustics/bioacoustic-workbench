class CreateAnalysisScripts < ActiveRecord::Migration
  def change
    # rails generate scaffold AnalysisScript name:string version:string  description:string  settings:string display_name:string extra_data:text
    create_table :analysis_scripts do |t|
      t.string :name
      t.string :version
      t.string :description
      t.string :settings
      t.string :display_name
      t.boolean :verified, :default => false
      t.text :extra_data
      t.text :notes

      t.timestamps
      t.userstamps include_deleted_by = true

      # needs to be added manually
      t.datetime :deleted_at
    end
    add_index :analysis_scripts, :name, :unique => true
  end
end
