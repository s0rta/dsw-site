class SchedulesController < ApplicationController
  def show
    @sessions = Submission.for_current_year.confirmed.includes(:submitter, :track, :votes)
  end
end
