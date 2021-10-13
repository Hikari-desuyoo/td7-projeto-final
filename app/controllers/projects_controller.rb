class ProjectsController < ApplicationController
    before_action :authenticate_hirer!, only: [:new, :create]

    def new
        @project = Project.new
    end

    def create
        @project = Project.new(project_params)
        @project.hirer = current_hirer

        if @project.save
            redirect_to @project
        else
            render :new
        end
    end

    def show
        @project = Project.find(params[:id])
        @owner_signed_in = hirer_signed_in? and @project.hirer == current_hirer
        @project_team = @project.get_team
        @team_worker_signed_in = current_worker ? @project_team.include?(current_worker) : false
        @member_signed_in = (@owner_signed_in or @team_worker_signed_in)

        @worker_applied = current_worker ? current_worker.projects.include?(@project) : false
        
        @project_status_notice = t(".#{@project.status}_project_notice")
    end

    def project_params 
        params.require(:project).permit(
            :title, :description, :skills_needed, 
            :max_pay_per_hour, :open_until, :remote, 
            :presential
        )

    end
end