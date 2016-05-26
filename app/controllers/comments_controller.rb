class CommentsController < ApplicationController

  respond_to :html

  def create
    @submission = Submission.find(params[:submission_id])
    @comment = @submission.comments.create(comment_params.merge(user_id: current_user.id))
    redirect_to @submission
  end

  private

  def comment_params
    params.require(:comment).permit(:body, :user_id)
  end

end
