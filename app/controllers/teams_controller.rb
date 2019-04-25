class TeamsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_team, only: [:show, :destroy, :edit, :update]

  def index
    @teams = current_user.teams.where.not(user_id: current_user.id)
    @myteams = current_user.myteams
    if params[:search].present?
      @team = Team.search(params[:search])
    else
      @team = 0;
    end
  end

  def edit; end

  def new
    @team = Team.new
  end

  def create
    @team = current_user.myteams.build(team_params)
    if @team.save
      user_team = UserTeam.create(user_id: current_user.id, team_id: @team.id)
      user_team.save
      redirect_to team_path(@team), notice: 'チームを作成しました'
    else
      render :new, status: :unprocessable_entity
    end
  end

  def show
    @tasks = Task.where(team_id: @team.id)
    @comment = TeamComment.new
    @comments = TeamComment.where(team_id: @team.id)
    if params[:search].present?
      @users = User.search(params[:search])
    else
      @users = 0;
    end
  end

  def update
    if @team.update(team_params)
      redirect_to team_path(@team), notice: 'チームを編集しました'
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    if @team.destroy
      redirect_to teams_path, notice: 'チームを削除しました'
    else
      render :index, status: :unprocessable_entity
    end
  end

  private

  def team_params
    params.require(:team).permit(:name, :teema, :user_id)
  end

  def set_team
      @team = Team.find(params[:id])
  end

end
