class SubmissionsController < ApplicationController

  respond_to  :html,
              :atom

  def index
    redirect_to feedback_closed_submissions_path unless FeatureToggler.feedback_active?
    @submissions = Submission.for_current_year.public.order('random()').includes(:submitter, :track, :votes)
  end

  def by_day
    @submissions = Submission.for_current_year.public.where(start_day: params[:day]).order('start_hour ASC').includes(:submitter, :track, :votes)
  end

  def new
    redirect_to submissions_closed_submissions_path unless FeatureToggler.submission_active?
    @submission = Submission.new(contact_email: current_user.try(:email))
  end

  def create
    @submission = current_user.submissions.new(params[:submission])
    @submission.year = Date.today.year
    if @submission.save
      redirect_to thanks_submissions_path
    else
      respond_with @submission
    end
  end

o def show
    @submission = Submission.public.where(id: params[:id].to_i).includes(:submitter, :track, :votes, :comments => :user).first!
  end

end
