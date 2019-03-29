class UsersController < ApplicationController
  before_action :authenticate_user!, only: [:edit]

  def show
    @user = User.find(params[:id])
    @tasks = @user.tasks.where(status: [0,1])
  end

  def edit
      @task = Task.find(params[:id])
  end
end
