class FavoritesController < ApplicationController
  before_action :authenticate_user!

  def index
    @favorites = current_user.favorites
  end

  def create
    favorite = current_user.favorites.build(task_id: params[:task_id])
    favorite.save
    redirect_to task_path(params[:task_id])
  end

  def destroy
    favorite = Favorite.find(params[:id])
    favorite.destroy
    redirect_to task_path(params[:task_id])
  end
end
