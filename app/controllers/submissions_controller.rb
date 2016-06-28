class SubmissionsController < ApplicationController

  respond_to  :html,
              :atom
  before_action :check_submissions_open, only: [ :new, :create ]
  before_action :authenticate_user!, only: [ :new, :create, :mine ]
  before_action :check_feedback_open, only: [ :index ]

  def index
    @submissions = Submission.
      for_current_year.
      joins(:track).
      where(tracks: { is_submittable: true }).
      public.
      order('random()').
      includes(:submitter, :track, :votes)
  end

  def track
    if params[:track_name].present?
      @submissions = Submission.fulltext_search(params[:terms]).
        for_current_year.
        for_submittable_tracks.
        for_track(params[:track_name]).
        public.
        order('random()').
        includes(:submitter, :track, :votes)
      render action: :index
    else
      redirect_to submissions_path(terms: params[:terms])
    end
  end

  def search
    if params[:track_name].present?
      redirect_to track_submissions_path(track_name: params[:track_name], terms: params[:terms])
    else
      @submissions = Submission.fulltext_search(params[:terms]).
        for_current_year.
        for_submittable_tracks.
        for_track(params[:track_name]).
        public.
        order('random()').
        includes(:submitter, :track, :votes)
      render action: :index
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
                                       :venue_id)
  end

  def check_submissions_open
    redirect_to submissions_closed_submissions_path unless FeatureToggler.submission_active?
  end

  def check_feedback_open
    redirect_to feedback_closed_submissions_path unless FeatureToggler.feedback_active?
  end

end
