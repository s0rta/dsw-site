class VotesController < ApplicationController

  respond_to :json

  def create
    @vote = current_user.votes.where(submission_id: params[:submission_id]).first_or_create
    render json: { count: @vote.submission.votes.count }.to_json
  end

end
