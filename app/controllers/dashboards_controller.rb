class DashboardsController < ApplicationController

  before_action :authenticate_user!

  def show
    @submissions = current_user.submissions.includes(:track).for_current_year
    @articles = current_user.articles
    @previous_submissions = current_user.submissions.for_previous_years.order('submissions.created_at DESC')
    @my_schedule = Submission.
      for_year(Date.today.year).
      for_schedule.
      my_schedule(current_user).
      order(:start_hour).
      includes(:venue,
              :submitter,
              :track,
              :cluster,
              sponsorship: :track)
  end

end
