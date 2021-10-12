 class ProjectApplicationsController < ApplicationController
    before_action :authenticate_worker!, only: [:create]

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
 end