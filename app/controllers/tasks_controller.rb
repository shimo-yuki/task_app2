class TasksController < ApplicationController
  before_action :set_task, only: [:show, :edit, :update, :destroy]
  before_action :edit_task, only: [:edit]
  before_action :authenticate_user!, only: [:new, :edit, :destroy, :update]

  def index
    @tasks = Task.where(status: [0,1])
  end

  def show; end

  def new
    @task = Task.new
  end

  def edit; end

  def create
    @task = Task.new(task_params)
    @task.user_id = current_user.id
    respond_to do |format|
      if @task.save
        format.html { redirect_to @task, notice: 'タスクの作成に成功しました。' }
        format.json { render :show, status: :created, location: @task }
      else
        format.html { render :new }
        format.json { render json: @task.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @task.update(task_params)
        format.html { redirect_to @task, notice: 'タスクの更新に成功しました。.' }
        format.json { render :show, status: :ok, location: @task }
      else
        format.html { render :edit }
        format.json { render json: @task.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @task.destroy
    respond_to do |format|
      format.html { redirect_to root_path, notice: 'タスクの削除に成功しました。' }
      format.json { head :no_content }
    end
  end

  private

  def set_task
    @task = Task.find(params[:id])
  end

  def edit_task
    if @task.user != current_user
      redirect_to root_path
    end
  end

  def task_params
    params.require(:task).permit(:title, :content, :deadline, :user_id, :status)
  end
end
