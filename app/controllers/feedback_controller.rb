class FeedbackController < ApplicationController

  before_action :authenticate_user!, only: :create

  def create
    @feedback = current_user.feedback.new(feedback_params)

    if @feedback.save
      flash[:notice] = 'Thank you for submitting feedback!'
    else
      flash[:error] = 'There was a problem submitting your feedback. Please try again later'
    end
    redirect_to schedule_path(@feedback.submission)
  end

  private

  def feedback_params
    params.require(:feedback).permit(:rating,
                                     :comments,
                                     :user_id,
                                     :submission_id)
  end
end
