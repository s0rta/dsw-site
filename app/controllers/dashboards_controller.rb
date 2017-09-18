class DashboardsController < ApplicationController

  before_action :authenticate_user!

  def show
    @submissions = current_user.submissions.for_current_year
    @previous_submissions = current_user.submissions.for_previous_years.order('submissions.created_at DESC')
  end

end
