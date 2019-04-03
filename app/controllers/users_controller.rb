class UsersController < ApplicationController
  before_action :set_user, only: [:show]
  before_action :set_tasks, only: [:show]

  private

  def set_user
    @user = User.find(params[:id])
  end

  def set_tasks
    @tasks = @user.tasks.visible
  end
end
