class SubmissionsController < ApplicationController

  respond_to :html 

  def new
    @submission = Submission.new(contact_email: current_user.try(:email))
  end

  def create
    @submission = Submission.new(params[:submission])
    if @submission.save
      redirect_to thanks_submissions_path
    else
      respond_with @submission
    end
  end

end
