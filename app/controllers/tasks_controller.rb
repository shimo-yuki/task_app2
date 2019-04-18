class TasksController < ApplicationController
  before_action :authenticate_user!, only: [:new, :edit, :destroy, :update]
  before_action :set_task, only: [:show]
  before_action :set_mytask, only: [:edit, :update, :destroy, :assign]
  before_action :set_select_team, only: [:team_select]
  before_action :set_team, only: [:show]

  def index
    @tasks = Task.visible
  end

  def new
    @task = Task.new
    @task.assigns.build
  end

  def show
    @comment = Comment.new
    @comments = @task.comments
  end

  def create
    @task = current_user.tasks.build(task_params)
    if params[:team_id] != nil
      @task.team_id = params[:team_id]
    end
    if @task.save
      binding.pry
      redirect_to @task, notice: 'タスクの作成に成功しました。'
    else
      render :new, status: :unprocessable_entity
    end
  end

  def update
    if @task.update(task_params)
      redirect_to @task, notice: 'タスクの更新に成功しました。'
    else
      render :edit
    end
  end

  def destroy
    @task.destroy
    redirect_to root_path, notice: 'タスクの削除に成功しました。'
  end

  def assign
  end

  def team_select
    @users = @team.users
  end

  private

  def set_task
    @task = Task.find(params[:id])
  end

  def set_team
    @team = Team.find_by(id: @task.team_id)
  end

  def set_mytask
    @task = current_user.tasks.find(params[:id])
  end

  def set_select_team
    @team = Team.find(params[:team_id])
  end

  def task_params
    params.require(:task).permit(:title, :content, :deadline, :user_id, {user_ids: []}, :status, :team_id)
  end
end
