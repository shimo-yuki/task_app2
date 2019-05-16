class ProjectsController < ApplicationController
    before_action :set_project, only: [:show, :destroy, :edit, :update]

    def index
        @admin_projects = Project.where(created_by: current_user)
        @projects = current_user.projects
        @new_projects = Project.limit(10).order("created_by DESC")
        if params[:search].present?
            @project = Project.search(params[:search])
        else
            @project = []
        end
    end

    def new
      @project = Project.new
    end

    def create
        @project = Project.new(project_params)
        @project.created_by = current_user.id
        if @project.save
          member = Member.create(user_id: current_user.id, project_id: @project.id)
          member.save
          redirect_to project_path(@project), notice: 'チームを作成しました'
        else
          render :new, status: :unprocessable_entity
        end
    end

    def show
      @tasks = Task.where(project_id: @project.id)
      # @comment = TeamComment.new
      # @comments = TeamComment.where(team_id: @team.id)
      if params[:search].present?
        @users = User.search(params[:search])
      else
        @users = User.where.not(id: @project.user_ids).limit(5)
        if @users.empty?
          @users = nil
        end
      end
    end

    def update
      if @project.update(project_params)
        redirect_to project_path(@peoject), notice: 'チームを編集しました'
      else
        render :edit, status: :unprocessable_entity
      end
    end


    private

    def project_params
        params.require(:project).permit(:name, :description)
    end

    def set_project
        @project = Project.find(params[:id])
    end
  
end
