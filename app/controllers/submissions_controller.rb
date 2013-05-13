class SubmissionsController < ApplicationController

  respond_to :html 

  def new
    @submission = Submission.new
  end

  def create
    @submission = Submission.new(params[:submission])
    @submission.save
    respond_with @submission
  end

end
