require "test_helper"

class ProjectsControllerTest < ActionDispatch::IntegrationTest
  # Using projects as an Admin User
  class AdminUsingProjectsControllerTest < ProjectsControllerTest
    setup do
      sign_in users(:admin)
      @project = projects(:one)
    end

    test "should get index" do
      get projects_url
      assert_response :success
    end

    test "should get new" do
      get new_project_url
      assert_response :success
    end

    test "should create project" do
      assert_difference("Project.count") do
        post projects_url, params: {
          project: {
            description: @project.description,
            name: @project.name,
          }
        }
      end
    end

    test "should show project" do
      get project_url(@project)
      assert_response :success
    end

    test "should get edit" do
      get edit_project_url(@project)
      assert_response :success
    end

    test "should update project" do
      patch project_url(@project), params: {
        project: {
          description: @project.description,
          name: @project.name
        }
      }
      assert_redirected_to project_url(@project)
    end

    test "should destroy project" do
      assert_difference("Project.count", -1) do
        delete project_url(@project)
      end

      assert_redirected_to projects_url
    end
  end

  class QAUsingProjectsControllerTest < ProjectsControllerTest
    setup do
      sign_in users(:qa)
      @project = projects(:one)
    end

    test "should get index" do
      get projects_url
      assert_response :success
    end

    # Only admins/managers can create projects
    test "should not be able to get new" do
      get new_project_url

      assert_response :redirect
      assert_equal "You cannot access this page", flash[:alert]
    end

    test "should not be able create projects" do
      assert_no_difference("Project.count") do
        post projects_url, params: {
          project: {
            description: @project.description,
            name: @project.name,
          }
        }
      end

      assert_response :redirect
      assert_equal "You cannot access this page", flash[:alert]
    end

    test "should show project" do
      get project_url(@project)
      assert_response :success
    end

    test "should get edit" do
      get edit_project_url(@project)
      assert_response :success
    end

    test "should update project" do
      patch project_url(@project), params: {
        project: {
          description: @project.description,
          name: @project.name
        }
      }
      assert_redirected_to project_url(@project)
    end

    test "should not be able to destroy project" do
      assert_no_difference("Project.count", -1) do
        delete project_url(@project)
      end

      assert_response :redirect
      assert_equal "You cannot access this page", flash[:alert]
    end
  end
end
