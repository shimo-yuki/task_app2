class ProjectsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_project, only: [:show, :destroy, :edit, :update]

  def index
      @admin_projects = Project.where(created_by: current_user)
      @projects = current_user.projects
      @new_projects = Project.limit(10).order("created_by DESC")
      if params[:search].present?
          # 検索ボタンを押されたら検索する
          @project = Project.search(params[:search])
      
        if @project.empty?
          #検索結果がなかったら配列の中身を空にする
          @project = []
        end
      end
  end

  def new
    @project = Project.new
  end

  def create
      @project = Project.new(project_params)
      @project.created_by = current_user.id
      if @project.save
        member = Member.new(user_id: current_user.id, project_id: @project.id)
        member.save
        redirect_to project_path(@project), notice: 'プロジェクトを作成しました'
      else
        render :new, status: :unprocessable_entity
      end
  end

  def show
    if params[:status] == '0' || params[:status].nil?
      @tasks = Task.where(project_id: @project.id)
    else
      @tasks = Task.where(project_id: @project.id, status: params[:status])
    end
    @comment = Comment::Project.new
    @comments = @project.comments
    if params[:search].present?
      @users = User.search(params[:search])
    else
      @users = User.where.not(id: @project.user_ids).limit(3)
      if @users.empty?
        @users = nil
      end
    end
  end

  def update
    if @project.update(project_params)
      redirect_to project_path(@peoject), notice: 'プロジェクトを編集しました'
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    if @project.destroy
      redirect_to projects_path, notice: 'プロジェクトを削除しました'
    else
      render :index, status: :unprocessable_entity
    end
  end

  private

  def project_params
    params.require(:project).permit(:name, :description)
  end

  def set_project
    @project = Project.friendly.find(params[:id])
  end

end
