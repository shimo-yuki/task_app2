class FavoritesController < ApplicationController
  before_action :authenticate_user!

  def index
    if params[:status] == '0' || params[:status].nil?
      @tasks = Task.where(user_id: current_user.id)
    else
      @tasks = Task.where(user_id: current_user.id, status: params[:status])
    end
  end

  def create
    favorite = current_user.favorites.build(task_id: params[:task_id])
    favorite.save
    flash[:notice] = "保存しました！"
    redirect_to task_path(params[:task_id])
  end

  def destroy
    favorite = Favorite.find(params[:id])
    favorite.destroy
    flash[:notice] = "保存解除しました！"
    redirect_to task_path(params[:task_id])
  end
end
