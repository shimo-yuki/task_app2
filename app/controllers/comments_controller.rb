class CommentsController < ApplicationController
  before_action :authenticate_user!

  def create
    @comment = current_user.comments.build(comment_params)
    @comment.save
    redirect_to task_path(@comment.task)
  end

  def destroy
    @comment = Comment.find(params[:id])
    @comment.destroy
    redirect_to task_path(@comment.task)
  end

  private

  def comment_params
    params.require(:comment).permit(:task_id, :content)
  end

end
