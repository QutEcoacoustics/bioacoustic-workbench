require 'test_helper'

class ProjectsControllerTest < ActionController::TestCase
  setup do
    @project = Project.first!
    @site_1 = Site.first!
    @site_2 = Site.offset(1).first!
    @site_3 = Site.offset(2).first!
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
    @old_name = @project.name
	@new_name = @project.name + " more text!"
    put :update, id: @project, project: { description: @project.description, urn: @project.urn, name: @new_name, notes: @project.notes }
    
	assert_equal @new_name, assigns(:project).name
	assert_redirected_to project_path(assigns(:project))
  end
  
  test "should update project with site" do
    put :update, id: @project, project: { description: @project.description, urn: @project.urn, name: @project.name, notes: @project.notes, site_ids: [ @site_1, @site_3 ]  }
    
	@new_sites = assigns(:project).sites
	assert_equal 2, @new_sites.count
	assert(@new_sites.include? @site_1)
	assert(@new_sites.include? @site_3)
	
	assert_redirected_to project_path(assigns(:project))
	assert_equal 'Project was successfully updated.', flash[:notice]
  end
  
  test "should update project by removing association with sites" do
    put :update, id: @project, project: { description: @project.description, urn: @project.urn, name: @project.name, notes: @project.notes, site_ids: [ @site_1, @site_3 ]  }
    
	@new_sites = assigns(:project).sites
	assert_equal 2, @new_sites.count
	assert(@new_sites.include? @site_1)
	assert(@new_sites.include? @site_3)
	
	assert_redirected_to project_path(assigns(:project))
	assert_equal 'Project was successfully updated.', flash[:notice]
	
	put :update, id: @project, project: { description: @project.description, urn: @project.urn, name: @project.name, notes: @project.notes, site_ids: [  ]  }
    
	@new_sites = assigns(:project).sites
	assert_equal 0, @new_sites.count
	
	assert_redirected_to project_path(assigns(:project))
	assert_equal 'Project was successfully updated.', flash[:notice]
  end

  test "should destroy project" do
    assert_difference('Project.count', -1) do
      delete :destroy, id: @project
    end

    assert_redirected_to projects_path
  end
  
  test "should create project with sites" do
    assert_difference('Project.count') do
      post :create, project: { name: @project.name, notes: @project.notes, description: @project.description, urn: @project.urn, site_ids: [ @site_2, @site_3 ] }
    end
	
	@new_sites = assigns(:project).sites
	assert_equal 2, @new_sites.count
	assert(@new_sites.include? @site_2)
	assert(@new_sites.include? @site_3)
	
    assert_redirected_to project_path(assigns(:project))
	assert_equal 'Project was successfully created.', flash[:notice]
  end
end
