class PitchContest::VotesController < ApplicationController

  before_action :check_voting_open
  before_action :authenticate_user!

  def create
    @vote = current_user.pitch_contest_votes.where(pitch_contest_entry_id: params[:entry_id]).first_or_create
    render json: { count: @vote.entry.votes.count }.to_json
  end

  private

  def check_voting_open
    redirect_to page_path(page: 'pitch') unless AnnualSchedule.pitch_voting_open?
  end

end
