class UsersController < ApplicationController
  before_action :authenticate_user!
  before_action :set_user, only: [:show]
  before_action :set_tasks, only: [:show]

  private

  def set_user
    @user = User.find(params[:id])
  end

  def set_tasks
    if params[:status] == '0' || params[:status].nil?
      @tasks = @user.tasks.all
    else
      @tasks = current_user.tasks.where(status: params[:status])
    end
  end
end
