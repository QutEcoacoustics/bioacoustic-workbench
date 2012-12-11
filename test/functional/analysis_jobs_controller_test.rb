require 'test_helper'

class AnalysisJobsControllerTest < ActionController::TestCase
  setup do
    @analysis_job = analysis_jobs(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:analysis_jobs)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create analysis_job" do
    assert_difference('AnalysisJob.count') do
      post :create, analysis_job: { data_set_identifier: @analysis_job.data_set_identifier, description: @analysis_job.description, name: @analysis_job.name, notes: @analysis_job.notes, script_description: @analysis_job.script_description, script_display_name: @analysis_job.script_display_name, script_extra_data: @analysis_job.script_extra_data, script_name: @analysis_job.script_name, script_settings: @analysis_job.script_settings, script_version: @analysis_job.script_version }
    end

    assert_redirected_to analysis_job_path(assigns(:analysis_job))
  end

  test "should show analysis_job" do
    get :show, id: @analysis_job
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @analysis_job
    assert_response :success
  end

  test "should update analysis_job" do
    put :update, id: @analysis_job, analysis_job: { data_set_identifier: @analysis_job.data_set_identifier, description: @analysis_job.description, name: @analysis_job.name, notes: @analysis_job.notes, script_description: @analysis_job.script_description, script_display_name: @analysis_job.script_display_name, script_extra_data: @analysis_job.script_extra_data, script_name: @analysis_job.script_name, script_settings: @analysis_job.script_settings, script_version: @analysis_job.script_version }
    assert_redirected_to analysis_job_path(assigns(:analysis_job))
  end

  test "should destroy analysis_job" do
    assert_difference('AnalysisJob.count', -1) do
      delete :destroy, id: @analysis_job
    end

    assert_redirected_to analysis_jobs_path
  end
end
