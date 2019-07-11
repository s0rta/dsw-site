class SubmissionsController < ApplicationController
  respond_to :html,
    :atom
  before_action :check_cfp_open, only: %i[new create]
  before_action :authenticate_user!, only: %i[new create mine submissions_closed]
  before_action :check_voting_open, only: %i[index show]
  before_action :set_submissions, only: %i[edit update]
  before_action :set_random_seed, only: %i[index track]

  def index
    @submissions = Submission
                   .fulltext_search(params[:terms])
                   .for_current_year
                   .for_submittable_tracks
                   .for_schedule_filter(params[:track_name], current_user)
                   .public
                   .includes(:submitter,
                             :track,
                             :cluster,
                             :company,
                             sponsorship: :track)
                   .order(Arel.sql("RANDOM()"))
                   .page(params[:page])

    respond_to do |format|
      format.html
      format.js do
        render json: { fragment: render_to_string(partial: 'submissions_list_items', formats: [:html]),
                       next_url: url_for(page: Integer(params[:page] || 1) + 1, seed: @seed) }
      end
    end
  end

  def new
    @submission = Submission.new(contact_email: current_user.try(:email))
  end

  def create
    @submission = current_user.submissions.new(submission_params)
    @submission.year = Date.today.year
    if @submission.save
      flash[:notice] = "Thanks! Your proposal has been received and you will receive an e-mail confirmation shortly"
      redirect_to dashboard_path
    else
      respond_with @submission
    end
  end

  def update
    @submission.update(proposed_updates: submission_params)
    if @submission.save
      flash[:notice] = "Thanks! Your changes have been submitted and are pending review."
      @submission.notify_track_chairs_of_update!
      redirect_to dashboard_path
    else
      respond_with @submission
    end
  end

  def show
    @submission = Submission
      .public
      .where(id: params[:id].to_i)
      .order(:start_day)
      .includes(:submitter, :track, :votes, comments: :user)
      .first!
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
      :target_audience_description,
      :coc_acknowledgement)
  end

  def check_cfp_open
    redirect_to submissions_closed_submissions_path unless AnnualSchedule.cfp_open?
  end

  def check_voting_open
    redirect_to feedback_closed_submissions_path unless AnnualSchedule.voting_open?
  end

  def set_submissions
    @submission = current_user.submissions.find(params[:id])
  end

  def set_random_seed
    @seed = (params[:seed] || rand).to_f
    ActiveRecord::Base.connection.execute("select setseed(#{ActiveRecord::Base.connection.quote(@seed)})")
  end
end
