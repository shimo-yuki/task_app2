class TasksController < ApplicationController
  before_action :authenticate_user!, only: [:new, :edit, :destroy, :update]
  before_action :set_task, only: [:show]
  before_action :set_mytask, only: [:edit, :update, :destroy, :assign]

  def index
    @tasks = Task.visible
  end

  def new
    @task = Task.new
    @task.assigns.build
  end

  def create
    @task = current_user.tasks.build(task_params)
    if @task.save
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
    @user = Team.find(params[:team_id]).users
    @user.unshift(["選択して下さい",""])
  end
  private

  def set_task
    @task = Task.find(params[:id])
  end

  def set_mytask
    @task = current_user.tasks.find(params[:id])
  end

  def task_params
    params.require(:task).permit(:title, :content, :deadline, :user_id, :status, :users_attributes => [:id, :user_id, :_destroy])
  end
end
