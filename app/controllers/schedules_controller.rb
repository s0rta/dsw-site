class SchedulesController < ApplicationController

  def index
    @sessions = Submission.for_current_year.confirmed.includes(:submitter, :track, :votes)
  end

  def show
    @session = Submission.confirmed.where(id: params[:id].to_i).includes(:submitter, :track, :comments => :user).first!
  end

end
