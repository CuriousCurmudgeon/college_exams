class AssignedExamsController < ApplicationController
  def create
    exam = Exam.find_by id: params[:exam_id]
    
    if exam.nil?
      render_json_error('Exam not found') and return
    end

    if exam.college_id != params[:college_id]
      render_json_error('Exam is for different college') and return
    end

    if !exam.in_exam_window?(DateTime.parse(params[:start_time]))
      render_json_error('Start time not in exam window') and return
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

  def render_json_error(message)
    render(json: { error: message }, :status => :bad_request)
  end
end
