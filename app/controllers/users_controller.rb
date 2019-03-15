class UsersController < ApplicationController
  before_action :set_user, only: [:show]
  before_action :set_task, only: [:edit]
  def index
  end

  def new
  end

  def show
    @tasks = @user.tasks.where(status: [0,1])
  end

  def edit;  end

  private
  def set_user
    @user = User.find(params[:id])
  end
  def set_task
    @task = Task.find(params[:id])
  end
end
