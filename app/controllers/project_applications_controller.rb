 class ProjectApplicationsController < ApplicationController
    before_action :authenticate_worker!, only: [:create]
    before_action :authenticate_hirer!, only: [:accept]

    def create
        @project = Project.find(params[:project_id])
        
        if current_worker.projects.include?(@project)
            redirect_to root_path
            return
        end

        @project_application = ProjectApplication.new(
            project: @project,
            worker: current_worker
        )

        if @project_application.save
            redirect_to @project, notice: t('.success')
        else
            redirect_to @project, notice: t('.failed')
        end
    end

    def accept
        @project_application = ProjectApplication.find(params[:id])
        @project_application.accepted!
        redirect_to @project_application.project
    end    

    def decline
        @project_application = ProjectApplication.find(params[:id])
        redirect_to @project_application.project
    end
 end