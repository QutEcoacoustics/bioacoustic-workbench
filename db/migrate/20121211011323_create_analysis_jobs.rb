class CreateAnalysisJobs < ActiveRecord::Migration
  def change
    # rails generate scaffold AnalysisJob  name:string  description:string  notes:text script_name:string
    # script_version:string  script_description:string  script_settings:string script_display_name:string
    # script_extra_data:text data_set_identifier:string saved_search:references
    create_table :analysis_jobs do |t|
      t.string :name
      t.string :description
      t.text :notes
      t.boolean :process_new
      t.string :script_name
      t.string :script_version
      t.string :script_description
      t.string :script_settings
      t.string :script_display_name
      t.text :script_extra_data
      t.string :data_set_identifier
      t.references :saved_search

      t.timestamps
      t.userstamps include_deleted_by = true
      t.datetime :deleted_at
    end
    add_index :analysis_jobs, :saved_search_id
  end
end
