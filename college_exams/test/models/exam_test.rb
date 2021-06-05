require "test_helper"

class ExamTest < ActiveSupport::TestCase
  test "should not save exam without college" do
    exam = Exam.new(start_time: DateTime.parse("2021-06-01"), end_time: DateTime.parse("2021-06-30"))
    assert_not exam.save, "Saved the exam without a college"
  end

  test "should not save exam without start_time" do
    college = College.create
    exam = Exam.new(college: college, end_time: DateTime.parse("2021-06-30"))
    assert_not exam.save, "Saved the exam without a start_time"
  end

  test "should not save exam without end_time" do
    college = College.create
    exam = Exam.new(college: college, start_time: DateTime.parse("2021-06-01"))
    assert_not exam.save, "Saved the exam without an end_time"
  end

  test "should not save when start_time is equal to end_time" do
    college = College.create
    time = DateTime.parse("2021-06-01T08:00:00")
    exam = Exam.new(college: college, start_time: time, end_time: time)
    assert_not exam.save, "Saved the exam when start and end times were equal"
  end

  test "should not save when start_time is after end_time" do
    college = College.create
    start_time = DateTime.parse("2021-06-01T08:00:00")
    exam = Exam.new(college: college, start_time: start_time, end_time: start_time - 1.hours)
    assert_not exam.save, "Saved the exam when the start time was after the end time"
  end

  test "should save valid exam" do
    college = College.create
    exam = Exam.new(college: college, start_time: DateTime.parse("2021-06-01"), end_time: DateTime.parse("2021-06-30"))
    assert exam.save
  end
end
