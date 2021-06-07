class AssignedExamsController < ApplicationController
  include Response

  before_action :validate_exam

  def create
    user = User.find_by(user_params)
    if user.nil?
      user = User.new(user_params)
    end
    
    @exam.users << user
    @exam.save

    render :status => :ok
  end

  private

  def validate_exam
    @exam = Exam.find_by id: params[:exam_id]
    
    if @exam.nil?
      render_bad_request('Exam not found') and return
    end

    if @exam.college_id != params[:college_id]
      render_bad_request('Exam is for different college') and return
    end

    if !@exam.in_exam_window?(DateTime.parse(params[:start_time]))
      render_bad_request('Start time not in exam window') and return
    end
  end

  def user_params
    params.permit(:first_name, :last_name, :phone_number)
  end
end
