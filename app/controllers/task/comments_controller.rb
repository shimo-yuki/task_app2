class Task::CommentsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_comment, only: [:destroy, :update]
  before_action :set_task, only: [:create, :update, :destroy]

  def create
    @comment = @task.comments.build(comment_params)
    @comment.user_id = current_user.id
    if @comment.save
      flash[:task] = 'タスクのコメントを作成しました'
      redirect_to task_path(@task)
    else
      @comments = @task.comments.where.not(id: nil)
      render 'tasks/show'
    end
  end

  def edit; end

  def update
    if @comment.update(comment_params)
      flash[:task] = 'タスクのコメントを編集しました'
      redirect_to task_path(@task)
    else
      @comments = @task.comments.where.not(id: nil)
      render 'tasks/show'
    end
  end

  def destroy
    @comment.destroy
    redirect_to task_path(@task)
  end

  private

  def set_task
    @task = Task.find(params[:task_id])
  end

  def set_comment
    @comment = Comment.find(params[:id])
  end

  def comment_params
    params.require(params[:type].underscore.gsub('/', '_').to_sym).permit(:content)
  end
end
