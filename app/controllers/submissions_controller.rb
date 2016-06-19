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

  def search
    ids = Submission.algolia_raw_search(params[:terms])['hits'].map { |h| h['objectID'] }.map(&:to_i)
    @submissions = Submission.where(id: ids).
      for_current_year.
      joins(:track).
      where(tracks: { is_submittable: true }).
      public.
      includes(:submitter, :track, :votes).
      order("idx(ARRAY#{ids}, submissions.id)")
    render action: :index
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
