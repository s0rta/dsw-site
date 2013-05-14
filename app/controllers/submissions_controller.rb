class SubmissionsController < ApplicationController

  respond_to :html 

  def new
    @submission = Submission.new(contact_email: current_user.try(:email))
  end

  def create
    @submission = Submission.new(params[:submission])
    @submission.save
    respond_with @submission
  end

end
