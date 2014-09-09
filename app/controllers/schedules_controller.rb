class SchedulesController < ApplicationController

  respond_to :html
  respond_to :json, only: :index

  before_filter :authenticate_user!, only: :my_schedule

  def index
    @sessions = Submission.for_current_year.
                           for_schedule.
                           order(:start_day).
                           includes(:venue, :submitter, :track)
    respond_with @sessions
  end

  def show
    @session = Submission.for_schedule.
      where(id: params[:id].to_i).
      order(:start_day).
      includes(:venue, :submitter, :track, comments: :user).
      first!
  end

  def my_schedule
    @my_schedule = true
    @sessions = current_registration.submissions.for_current_year.
                           for_schedule.
                           includes(:venue, :submitter, :track)
    render action: :index
  end

  def create
    submission = Submission.for_schedule.
      where(id: params[:id].to_i).
      includes(:submitter, :track, comments: :user).
      first!
    current_registration.submissions << submission unless current_registration.submissions.include?(submission)
    render json: submission.session_registrations.count
  end

  def destroy
    submission = Submission.for_schedule.
      where(id: params[:id].to_i).
      includes(:submitter, :track, comments: :user).
      first!
    current_registration.session_registrations.where(submission_id: submission.id).destroy_all
    render json: submission.session_registrations.count
  end

end
