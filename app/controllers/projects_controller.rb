class ProjectsController < ApplicationController
    before_action :authenticate_hirer!, only: [:new, :create, :my_projects]

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
        
        @project_status = t(".#{@project.status}_project")
        
        set_feedback_attributes

    end

    def finish
        @project = Project.find(params[:id])
        if project_owner?
            @project.finished!
        end

        redirect_to @project
    end

    def close
        @project = Project.find(params[:id])
        if project_owner?
            @project.closed!
        end

        redirect_to @project
    end

    def my_projects
        @projects = current_hirer.projects
    end

    private
    def set_feedback_attributes
        @project_average_score = @project.project_feedbacks.average(:score)

        @feedbacks = @project.project_feedbacks

        @your_feedback = false
        
        if worker_signed_in?
            feedback_query = current_worker.project_feedbacks.where(:project => @project)
            unless feedback_query.empty?
                @your_feedback = feedback_query[0]
            end
        end

        if @project_average_score == nil then @project_average_score = '-' end
    end

    def project_params 
        params.require(:project).permit(
            :title, :description, :skills_needed, 
            :max_pay_per_hour, :open_until, :remote, 
            :presential
        )
    end

    def project_owner?
        @project.hirer == current_hirer
    end
end