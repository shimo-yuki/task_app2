class TasksController < ApplicationController
  before_action :authenticate_user!, only: [:new, :show, :edit, :destroy, :update]
  before_action :set_task, only: [:show]
  before_action :set_mytask, only: [:edit, :update, :destroy]


  def index
    if params[:status] == '0' || params[:status].nil?
      @tasks = Task.all
    else
      @tasks = Task.where(status: params[:status])
    end
  end

  def new
    if params[:project_id]
      @project = Project.friendly.find(params[:project_id])
    end
    @task = Task.new
  end

  def show
    @task_comment = Comment.new type: "CommentTask"
  end

  def create
    @task = Task.new(task_params)
    if params[:project_id]
      @task.project_id = params[:project_id]
    end
    if @task.save
      redirect_to @task, notice: 'タスクを作成しました'
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
    if @task.project_id
      @project = Project.find(@task.project_id)
    end
  end

  def update
    if @task.update(task_params)
      redirect_to @task, notice: 'タスクを更新しました'
    else
      render :edit
    end
  end

  def destroy
    @task.destroy
    redirect_to root_path, notice: 'タスクを削除しました'
  end

  def assign
  end

  def set_edit_task
    @task = Task.find(params[:task_id])
    @users = @task.users.order(:id)
  end

  def team_select
    @users = @team.users
  end

  private

  def set_task
    @task = Task.find(params[:id])
  end

  def set_team
    @project = Project.find_by(id: @task.team_id)
  end

  def set_mytask
    @task = current_user.tasks.find(params[:id])
  end


  def task_params
    params.require(:task).permit(:title, :content, :deadline, :status, :user_id)
  end

end
