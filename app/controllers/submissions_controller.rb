class SubmissionsController < ApplicationController
  respond_to :html, :atom
  skip_before_action :store_location, only: %i[new edit feedback_closed]
  before_action :check_cfp_open, only: %i[new create]
  before_action :check_voting_open, only: %i[index show]
  before_action :authenticate_user!, only: %i[new create edit update mine]
  before_action :set_submission, only: %i[edit update]
  before_action :set_random_seed, only: %i[index track]

  def index
    @submissions = Submission
      .fulltext_search(params[:terms])
      .for_current_year
      .for_submittable_tracks
      .for_schedule_filter(params[:track_name], current_user)
      .for_public
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
        render json: {fragment: render_to_string(partial: "submissions_list_items", formats: [:html]),
                      next_url: url_for(page: Integer(params[:page] || 1) + 1, seed: @seed)}
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
      flash[:error] = "Sorry, we could not save your proposal: #{@submission.errors.full_messages.to_sentence}"
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
      flash[:error] = "Sorry, we could not save your changes: #{@submission.errors.full_messages.to_sentence}"
      respond_with @submission
    end
  end

  def show
    @submission = Submission
      .for_public
      .where(id: params[:id].to_i)
      .order(:start_day)
      .includes(:submitter, :track, :votes, comments: :user)
      .first!
  end

  private

  def submission_params
    params
      .require(:submission)
      .permit(
        :cluster_id,
        :coc_acknowledgement,
        :company_name,
        :contact_email,
        :dei_acknowledgement,
        :description,
        :estimated_size,
        :format,
        :from_underrepresented_group,
        :location,
        :notes,
        :open_to_collaborators,
        :preferred_length,
        :proposal_video_url,
        :start_day,
        :target_audience_description,
        :time_range,
        :title,
        :track_id,
        :venue_id
      )
  end

  def check_cfp_open
    unless AnnualSchedule.cfp_open? ||
        user_signed_in? && (
          current_user.is_admin? ||
          current_user.has_valid_cfp_extension?)
      redirect_back notice: "Session submissions for #{Date.today.year} are currently closed",
                    fallback_location: dashboard_path
    end
  end

  def check_voting_open
    redirect_to feedback_closed_submissions_path unless AnnualSchedule.voting_open?
  end

  def set_submission
    @submission = current_user.submissions.find(params[:id])
  end

  def set_random_seed
    @seed = (params[:seed] || rand).to_f
    ActiveRecord::Base.connection.execute("select setseed(#{ActiveRecord::Base.connection.quote(@seed)})")
  end
end
