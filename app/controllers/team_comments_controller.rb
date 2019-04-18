class TeamCommentsController < ApplicationController
  protect_from_forgery :except => [:create]
  before_action :authenticate_user!
  before_action :set_comment, only: [:destroy, :edit, :update]

  def create
    @comment = TeamComment.new(comment: params[:comment], team_id: params[:team_id], user_id: params[:user_id])
    @comment.user_id = current_user.id
    @comment.save
  end

  def destroy
    @comment.destroy
    redirect_to team_path(@comment.team_id)
  end

  def edit; end

  def update
    @comment.update(comment_params)
    redirect_to team_path(@comment.team_id)
  end

  private

  def set_comment
    @comment = TeamComment.find(params[:id])
  end

  def comment_params
    params.require(:team_comment).permit(:comment, :team_id)
  end
end
