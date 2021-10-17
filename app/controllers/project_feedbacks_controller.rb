class ProjectFeedbacksController < ApplicationController
    before_action :authenticate_worker!
    def new
        @project = Project.find(params[:project_id])
        @feedback = ProjectFeedback.new()
    end

    def create
        @feedback = ProjectFeedback.new(feedback_params)
        @project = Project.find(params[:project_id])
        if already_feedback
            redirect_to @project
            return
        end

        @feedback.project = @project
        @feedback.worker = current_worker

        if @feedback.save
            redirect_to @project, notice: t('feedbacks.create.submit_success')
        else
            render :new
        end
    end

    private
    def already_feedback
        not @project.project_feedbacks.where(worker: current_worker).empty?
    end

    def feedback_params 
        params.require(:project_feedback).permit(
            :score, :comment
        )
    end
end