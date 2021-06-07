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

  test "in_exam_window? should return true if param equals start_time" do
    exam = new_date_testing_exam
    assert exam.in_exam_window?(exam.start_time)
  end

  test "in_exam_window? should return false if param one day before start_time" do
    exam = new_date_testing_exam
    assert_not exam.in_exam_window?(exam.start_time - 1.day)
  end

  test "in_exam_window? should return false if param one second before start_time" do
    exam = new_date_testing_exam
    assert_not exam.in_exam_window?(exam.start_time - 1.second)
  end

  test "in_exam_window? should return true if param between start_time and end_time" do
    exam = new_date_testing_exam
    assert exam.in_exam_window?(exam.start_time + 1.day)
  end

  test "in_exam_window? should return true if param one second after start_time" do
    exam = new_date_testing_exam
    assert exam.in_exam_window?(exam.start_time + 1.second)
  end

  test "in_exam_window? should return true if param equals end_time" do
    exam = new_date_testing_exam
    assert exam.in_exam_window?(exam.end_time)
  end

  test "in_exam_window? should return false if param one day past end_time" do
    exam = new_date_testing_exam
    assert_not exam.in_exam_window?(exam.end_time + 1.day)
  end

  test "in_exam_window? should return false if param one second past end_time" do
    exam = new_date_testing_exam
    assert_not exam.in_exam_window?(exam.end_time + 1.second)
  end

  private

  def new_date_testing_exam
    Exam.new(start_time: DateTime.parse("2021-06-01"), end_time: DateTime.parse("2021-06-30"))
  end
end
