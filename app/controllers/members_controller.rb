class MembersController < ApplicationController
  before_action :authenticate_user!

    def create
      @project = Project.friendly.find(params[:project_id])
      member = Member.new(user_id: params[:user_id], project_id: @project.id)
      member.save
      redirect_to project_path(params[:project_id])
      end
end
