class VotesController < ApplicationController
  before_action :authenticate_user!, only: %i[create]
  respond_to :html, :json

  def create
    @submission = Submission.find(params[:submission_id])
    @vote = submission.votes.where(user_id: current_user.id).first_or_create
    respond_to do |format|
      format.html { redirect_to submission_path(@submission) }
      format.json { render json: {count: @vote.submission.votes.count}.to_json }
    end
  end
end
