class AssignedExamsController < ApplicationController
  def create
    exam = Exam.find_by id: params[:exam_id], college_id: params[:college_id]
    
    if exam.nil? || !exam.in_exam_window?(DateTime.parse(params[:start_time]))
      render :status => :bad_request and return
    end

    user = User.find_by(user_params)
    if user.nil?
      user = User.new(user_params)
    end
    
    exam.users << user
    exam.save

    render :status => :ok
  end

  private

  def user_params
    params.permit(:first_name, :last_name, :phone_number)
  end
end
