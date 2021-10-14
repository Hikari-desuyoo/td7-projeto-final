class ProjectFeedbacksController < ApplicationController
    before_action :authorize_worker_access
    def new
        @project = Project.find(params[:project_id])
        @feedback = ProjectFeedback.new()
    end

    def create
        @feedback = ProjectFeedback.new(feedback_params)
        @project = Project.find(params[:project_id])
        @feedback.project = @project
        @feedback.worker = current_worker

        if @feedback.save
            redirect_to @project, notice: t('feedbacks.create.submit_success')
        else
            render :new
        end
    end

    private
    def authorize_worker_access
    end

    def feedback_params 
        params.require(:project_feedback).permit(
            :score, :comment
        )
    end
end