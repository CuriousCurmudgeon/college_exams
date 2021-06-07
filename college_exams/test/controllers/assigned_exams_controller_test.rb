require "test_helper"

class AssignedExamsControllerTest < ActionDispatch::IntegrationTest
  test "post should create assigned exam" do
    user = User.first
    exam = Exam.first
    assert_difference("AssignedExam.count") do
      post assigned_exams_path, params: { 
        first_name: user.first_name,
        last_name: user.last_name,
        phone_number: user.phone_number, 
        college_id: College.first.id,
        exam_id: exam.id,
        start_time: exam.start_time + 1.day}, as: :json
    end
    
    assert_response :success
  end

  test "post should not create new user if matching user found" do
    user = User.first
    exam = Exam.first
    assert_no_difference("User.count") do
      post assigned_exams_path, params: { 
        first_name: user.first_name,
        last_name: user.last_name,
        phone_number: user.phone_number, 
        college_id: College.first.id,
        exam_id: exam.id,
        start_time: exam.start_time + 1.day}, as: :json
    end
    
    assert_response :success
  end

  test "post should create new user if matching user not found" do
    user = User.first
    exam = Exam.first
    assert_difference("User.count") do
      post assigned_exams_path, params: { 
        first_name: "unknown",
        last_name: user.last_name,
        phone_number: user.phone_number, 
        college_id: College.first.id,
        exam_id: exam.id,
        start_time: exam.start_time + 1.day}, as: :json
    end
    
    assert_response :success
  end

  test "post should return 400 if exam_id invalid" do
    post assigned_exams_path, params: { 
      first_name: "Devin",
      last_name: "Townsend",
      phone_number: "0293840239", 
      college_id: College.first.id,
      exam_id: "123",
      start_time: "2021-06-07"}, as: :json

      assert_response :bad_request
      assert_json_error 'Exam not found'
  end

  test "post should return 400 if college_id invalid" do
    post assigned_exams_path, params: { 
      first_name: "Devin",
      last_name: "Townsend",
      phone_number: "0293840239", 
      college_id: "123",
      exam_id: Exam.first.id,
      start_time: "2021-06-07"}, as: :json

      assert_response :bad_request
      assert_json_error 'Exam is for different college'
  end

  test "post should return 400 if start_time not in exam window" do
    exam = Exam.first
    post assigned_exams_path, params: { 
      first_name: "Devin",
      last_name: "Townsend",
      phone_number: "0293840239", 
      college_id: College.first.id,
      exam_id: exam.id,
      start_time: exam.start_time - 1.day}, as: :json

      assert_response :bad_request
      assert_json_error 'Start time not in exam window'
  end

  private

  def assert_json_error(message)
    json_response = JSON.parse(response.body)
    assert_equal message, json_response["error"]
  end
end
