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
    end

    def project_params 
        params.require(:project).permit(
            :title, :description, :skills_needed, 
            :max_pay_per_hour, :open_until, :remote, 
            :presential
        )

    end
end