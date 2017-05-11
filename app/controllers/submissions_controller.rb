class SubmissionsController < ApplicationController

  respond_to  :html,
              :atom
  before_action :check_submissions_open, only: [ :new, :create ]
  before_action :authenticate_user!, only: [ :new, :create, :mine, :submissions_closed ]
  before_action :check_feedback_open, only: [ :index ]
  before_action :set_submissions, only: [:edit, :update]

  def index
    @submissions = Submission.
      for_current_year.
      for_submittable_tracks.
      public.
      order('created_at DESC').
      page(params[:page])
  end

  def track
    if params[:track_name].present?
      @submissions = Submission.
        fulltext_search(params[:terms]).
        for_current_year.
        for_submittable_tracks.
        for_schedule_filter(params[:track_name], current_user).
        public.
        order('created_at DESC').
        page(params[:page])
      respond_to do |format|
        format.html
        format.js do
          render json: { fragment: render_to_string(partial: 'track_contents', formats: [ :html ]),
                         next_url: url_for(page: Integer(params[:page] || 1) + 1) }
        end
      end
    else
      redirect_to submissions_path(terms: params[:terms])
    end
  end

  def search
    if params[:track_name].present?
      redirect_to track_submissions_path(track_name: params[:track_name], terms: params[:terms])
    else
      @submissions = Submission.
        fulltext_search(params[:terms]).
        for_current_year.
        for_submittable_tracks.
        for_schedule_filter(params[:track_name], current_user).
        public.
        page(params[:page])
      respond_to do |format|
        format.json do
          render json: { fragment: render_to_string(partial: 'track_contents', formats: [ :html ]),
                         next_url: url_for(page: Integer(params[:page] || 1) + 1) }
        end
        format.html { render action: :track }
      end
    end
  end

  def mine
    @submissions = current_user.submissions.for_current_year
    @previous_submissions = current_user.submissions.for_previous_years.order('created_at DESC')
  end

  def by_day
    @submissions = Submission.for_current_year.public.where(start_day: params[:day]).order('start_hour ASC').includes(:submitter, :track, :votes)
  end

  def new
    @submission = Submission.new(contact_email: current_user.try(:email))
  end

  def create
    @submission = current_user.submissions.new(submission_params)
    @submission.year = Date.today.year
    if @submission.save
      flash[:notice] = 'Thanks! Your proposal has been received and you will receive an e-mail confirmation shortly'
      redirect_to mine_submissions_path
    else
      respond_with @submission
    end
  end

  def edit
  end

  def update
    @submission.update(proposed_updates: submission_params)
    if @submission.save
      flash[:notice] = 'Thanks! Your changes have been submitted and are pending review.'
      @submission.notify_track_chairs_of_update
      redirect_to mine_submissions_path
    else
      respond_with @submission
    end
  end

  def show
    @submission = Submission.public.
      where(id: params[:id].to_i).
      order(:start_day).
      includes(:submitter, :track, :votes, comments: :user).
      first!
  end

  private

  def submission_params
    params.require(:submission).permit(:start_day,
                                       :description,
                                       :format,
                                       :location,
                                       :notes,
                                       :time_range,
                                       :title,
                                       :track_id,
                                       :contact_email,
                                       :estimated_size,
                                       :venue_id,
                                       :cluster_id,
                                       :open_to_collaborators,
                                       :from_underrepresented_group,
                                       :company_name,
                                       :target_audience_description)
  end

  def check_submissions_open
    redirect_to submissions_closed_submissions_path unless EventSchedule.submissions_open?
  end

  def check_feedback_open
    redirect_to feedback_closed_submissions_path unless EventSchedule.feedback_open?
  end

  def set_submissions
    @submission = current_user.submissions.find(params[:id])
  end

end
