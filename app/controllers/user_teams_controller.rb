class UserTeamsController < ApplicationController

  def create
    user_team = UserTeam.create(user_id: params[:user_id],team_id: params[:team_id])
    user_team.save
    redirect_to team_path(params[:team_id])
  end
end
