class TeamsController < ApplicationController
  before_action :authenticate_user!

  def index
    @teams = current_user.teams
    @myteams = current_user.myteams
  end

  def new
    @team = Team.new
  end

  def create
    @team = current_user.myteams.build(team_params)
    @team.save
    redirect_to team_path(@team)
  end

  def show
    @team = Team.find(params[:id])
    @tasks = @team.tasks
    if params[:search].present?
      @users = User.search(params[:search])
    else
      @users = 0;
    end
  end

  private

  def team_params
    params.require(:team).permit(:name, :teema, :user_id)
  end
end
