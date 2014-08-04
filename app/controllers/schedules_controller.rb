class SchedulesController < ApplicationController

  def index
    @sessions = Submission.for_current_year.
                           for_schedule.
                           includes(:submitter, :track, :votes)
  end

  def show
    @session = Submission.for_schedule.
      where(id: params[:id].to_i).
      includes(:submitter, :track, comments: :user).
      first!
  end

end
