class CommentsController < ApplicationController

  respond_to :html

  def create
    @submission = Submission.find(params[:submission_id])
    @comment = @submission.comments.create(params[:comment].merge(user_id: current_user.id))
    redirect_to @submission
  end

end
