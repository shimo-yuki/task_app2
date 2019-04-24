class CommentsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_comment, only: [:edit, :destroy, :update]

  def create
    @comment = current_user.comments.build(comment_params)
    @comment.save
    redirect_to task_path(@comment.task)
  end

  def edit; end

  def update
    @comment.update(comment_params)
    redirect_to task_path(@comment.task)
  end

  def destroy
    @comment.destroy
    redirect_to task_path(@comment.task)
  end

  private

  def set_comment
    @comment = Comment.find(params[:id])
  end

  def comment_params
    params.require(:comment).permit(:task_id, :content)
  end

end
