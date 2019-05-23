class CommentsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_comment, only: [:edit, :destroy, :update]

  def create
    if params[:type] == "Comment::Task"
      @com = Task.find(params[:id])
    else
      @com = Project.find(params[:id])
    end
    @comment = @com.comments.build(comment_params)
    @comment.user_id = current_user.id  
    @comment.save
    if params[:type] == "Comment::Task"
      redirect_to task_path(@com)
    else
      redirect_to project_path(@com)
    end
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
    params.require(params[:type].underscore.gsub('/', '_').to_sym).permit(:content)
  end

end
