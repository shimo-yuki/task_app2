class MembersController < ApplicationController
    def create
        member = Member.create(user_id: params[:user_id],project_id: params[:project_id])
        member.save
        redirect_to project_path(params[:project_id])
      end
end
