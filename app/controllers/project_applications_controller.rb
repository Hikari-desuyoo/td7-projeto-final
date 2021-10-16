 class ProjectApplicationsController < ApplicationController
    before_action :authenticate_worker!, only: [:create]
    before_action :authenticate_hirer!, only: [:accept]


    # NOT NESTED ON PROJECT ROUTES
    def show
        @project_application = ProjectApplication.find(params[:id])
        application_from_linked_users_authetication!
    end

    # NESTED ON PROJECT ROUTES
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
            redirect_to @project_application, notice: t('.success_notice')
        end
    end    

    def decline
        @project_application = ProjectApplication.find(params[:id])
        @project_application.declined!
        decline_params = params.require(:project_application).permit(
            :decline_reason
        )

        @project_application.update!(decline_params)
        if @project_application.declined?
            redirect_to @project_application, notice: t('.success_notice')
        end
    end

    private
    def application_for_current_hirer!
        if hirer_signed_in? and current_hirer != @project_application.project.hirer
            redirect_to root_path
        end
    end

    def application_from_current_worker!
        if worker_signed_in? and current_worker != @project_application.worker
            redirect_to root_path
        end
    end

    def application_from_linked_users_authetication!
        application_for_current_hirer!
        application_from_current_worker!
    end
 end