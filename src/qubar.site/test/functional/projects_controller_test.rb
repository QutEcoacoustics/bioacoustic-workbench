require 'test_helper'

class ProjectsControllerTest < ActionController::TestCase
  setup do
    @project = projects(:project_one)
	@site_1 = sites(:site_two)
	@site_2 = sites(:site_three)
	@project.sites << @site_1
	@project.sites << @site_2
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:projects)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create project" do
    assert_difference('Project.count') do
      post :create, project: { name: @project.name, notes: @project.notes, description: @project.description, urn: @project.urn  }
    end

    assert_redirected_to project_path(assigns(:project))
  end

  test "should show project" do
    get :show, id: @project
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @project
    assert_response :success
  end

  test "should update project" do
    put :update, id: @project, project: { description: @project.description, urn: @project.urn, name: @project.name, notes: @project.notes }
    assert_redirected_to project_path(assigns(:project))
  end

  test "should destroy project" do
    assert_difference('Project.count', -1) do
      delete :destroy, id: @project
    end

    assert_redirected_to projects_path
  end
  
  test "should create project with sites" do
    assert_difference('Project.count') do
      post :create, project: { name: @project.name, notes: @project.notes, description: @project.description, urn: @project.urn  }
    end
	
	# assert_nil assigns(:project).errors
    assert_redirected_to project_path(assigns(:project))
  end
end
