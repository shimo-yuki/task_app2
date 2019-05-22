class CommentsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_comment, only: [:edit, :destroy, :update]

  def create
    @comment = Comment.new(comment_params)
    @comment.user_id = current_user.id
  
    
    @comment.save
    redirect_to task_path(id: 1)
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
    params.require(:comment).permit(:content, :type)
  end

end
