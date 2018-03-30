class FeedbackController < ApplicationController

  before_action :authenticate_user!, only: %i(create)

  def create
    @feedback = current_user.feedback.new(feedback_params)

    if @feedback.save
      flash[:notice] = 'Thank you for submitting feedback!'
      redirect_to schedule_path(@feedback.submission)
    else
      flash[:error] = 'there was a problem submitting feedback'
      redirect_to schedule_path(@feedback.submission)
    end
  end

  private

  def feedback_params
    params.require(:feedback).permit(:rating,
                                     :comments,
                                     :user_id,
                                     :submission_id)
  end
end
