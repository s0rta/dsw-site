class PitchContest::EntriesController < ApplicationController

  before_action :check_voting_open

  def index
    @entries = PitchContest::Entry.for_current_year.active.order(:name).includes(:votes)
  end

  private

  def check_voting_open
    redirect_to page_path(page: 'pitch') unless EventSchedule.pitch_voting_open?
  end
end
