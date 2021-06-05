require "test_helper"

class UserTest < ActiveSupport::TestCase
  test "should not save user without first_name" do
    user = User.new(last_name: "Doe", phone_number: "1234567890")
    assert_not user.save, "Saved the user without a first_name"
  end

  test "should not save user without last_name" do
    user = User.new(first_name: "Jane", phone_number: "1234567890")
    assert_not user.save, "Saved the user without a last_name"
  end

  test "should not save user without phone_number" do
    user = User.new(first_name: "Jane", last_name: "Doe")
    assert_not user.save, "Saved the user without a phone_number"
  end

  test "should not save user if phone_number has non-numeric characters" do
    user = User.new(first_name: "Jane", last_name: "Doe", phone_number: "(123)456-7890")
    assert_not user.save, "Saved the user without a phone_number"
  end

  test "should save valid user" do
    user = User.new(first_name: "Jane", last_name: "Doe", phone_number: "1234567890")
    assert user.save
  end

  test "should save when adding Exam" do
    user = User.new(first_name: "Jane", last_name: "Doe", phone_number: "1234567890")

    college = College.create
    exam = Exam.new(college: college, start_time: DateTime.parse("2021-06-01"), end_time: DateTime.parse("2021-06-30"))
    user.exams << exam
    assert user.save
  end
end
