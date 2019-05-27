class Project::CommentsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_project, only: [:create, :destroy, :update]
  before_action :set_comment, only: [:destroy, :update]

  def create
    @comment = @project.comments.build(comment_params)
    @comment.user_id = current_user.id
    if @comment.save
      flash[:notice] = 'プロジェクトのコメントを作成しました'
      redirect_to project_path(@project)
    else
      @tasks = Task.where(project_id: @project.id)
      @users = User.where.not(id: @project.user_ids).limit(3)
      @comments = @project.comments.where.not(id: nil)
      render 'projects/show'
    end
  end

  def update
    if @comment.update(comment_params)
      flash[:notice] = 'プロジェクトのコメントを編集しました'
      redirect_to project_path(@project)
    else
      @comments = @project.comments.where.not(id: nil)
      render 'projects/show'
    end
  end

  def destroy
    @comment.destroy
    flash[:notice] = 'プロジェクトのコメントを削除しました'
    redirect_to project_path(@project)
  end

  private

  def set_project
    @project = Project.find(params[:project_id])
  end

  def set_comment
    @comment = Comment.find(params[:id])
  end

  def comment_params
    params.require(params[:type].underscore.gsub('/', '_').to_sym).permit(:content)
  end
end
