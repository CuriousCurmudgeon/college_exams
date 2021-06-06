require "test_helper"

class AssignedExamsControllerTest < ActionDispatch::IntegrationTest
  test "should get create" do
    get assigned_exams_create_url
    assert_response :success
  end
end
