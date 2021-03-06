class Exam < ApplicationRecord
  belongs_to :college
  has_many :assigned_exams
  has_many :users, through: :assigned_exams

  validates :start_time, :end_time, presence: true
  validate :end_time_after_start_time

  def in_exam_window?(date_time)
    date_time >= start_time && date_time <= end_time
  end

  private

  def end_time_after_start_time
    return if end_time.blank? || start_time.blank?

    if (end_time <= start_time)
      errors.add(:end_time, "must be after the start_time")
    end
  end
end
