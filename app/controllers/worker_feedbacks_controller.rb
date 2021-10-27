class WorkerFeedbacksController < ApplicationController
    before_action :authenticate_hirer!
    def new
        @feedback = WorkerFeedback.new()
        @worker = Worker.find(params[:worker_id])
    end

    def create
        @feedback = WorkerFeedback.new(feedback_params)
        @worker = Worker.find(params[:worker_id])

        @feedback.worker = @worker
        @feedback.hirer = current_hirer

        if @feedback.save
            redirect_to @worker, notice: t('feedbacks.create.submit_success')
        else
            redirect_to @worker
        end
    end

    private
    def cant_feedback
        zero_feedbacks = @worker.worker_feedbacks.where(hirer: current_hirer).empty?
        #There's probably a better way to do this
        involved = @worker.get_feedbackable_project_id.intersection(current_hirer.projects.pluck(:id)).any?
        
        not (zero_feedbacks and involved)
    end

    def feedback_params 
        params.require(:worker_feedback).permit(
            :score, :comment
        )
    end
end