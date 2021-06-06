class AssignedExamsController < ApplicationController
  def create
    # Load the exam by ID and college ID
    exam = Exam.find_by id: params[:exam_id], college_id: params[:college_id]
    # Check if we got a result, 400 if no result
    if exam.nil? || !exam.in_exam_window?(DateTime.parse(params[:start_time]))
      render :status => :bad_request and return
    end

    # Load the user that matches the name and phone number
    user = User.find_by first_name: params[:first_name], last_name: params[:last_name], phone_number: params[:phone_number]
    if user.nil?
      # Create a new user if a match was not found
      user = User.new
      user.first_name = params[:first_name]
      user.last_name = params[:last_name]
      user.phone_number = params[:phone_number]
    end
    
    # Assign the exam to the new user and save
    exam.users << user
    exam.save

    # return 200
    render :status => :ok
  end
end
