class CreateAnalysisItems < ActiveRecord::Migration
  def change
    # rails generate scaffold AnalysisItems worker_info:string worker_started_utc:datetime worker_run_details:text
    # status:string offset_start_seconds:decimal offset_end_seconds:decimal audio_recording:references
    # analysis_job:references
    create_table :analysis_items do |t|
      t.string :worker_info
      t.datetime :worker_started_utc
      t.text :worker_run_details
      t.string :status, :default => :ready
      t.decimal :offset_start_seconds
      t.decimal :offset_end_seconds
      t.references :audio_recording
      t.references :analysis_job

      t.timestamps
    end
    add_index :analysis_items, :audio_recording_id
    add_index :analysis_items, :analysis_job_id
  end
end
