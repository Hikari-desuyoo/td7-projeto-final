 class ProjectApplicationsController < ApplicationController
    before_action :authenticate_worker!, only: [:create]
    before_action :authenticate_hirer!, only: [:accept]

    def create
        @project = Project.find(params[:project_id])
        
        description = params[:description]
        
        if current_worker.projects.include?(@project)
            redirect_to root_path
            return
        end

        @project_application = ProjectApplication.new(
            project: @project,
            worker: current_worker,
            description: description
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
        if @project_application.accepted?
            redirect_to @project_application.project, notice: t('.success_notice')
        end
    end    

    def decline
        @project_application = ProjectApplication.find(params[:id])
        @project_application.declined!
        if @project_application.declined?
            redirect_to @project_application.project, notice: t('.success_notice')
        end
    end
 end