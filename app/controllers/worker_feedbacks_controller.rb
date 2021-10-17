class WorkerFeedbacksController < ApplicationController
    before_action :authenticate_hirer!
    def new
        @feedback = WorkerFeedback.new()
        @worker = Worker.find(params[:worker_id])
    end

    def create
        @feedback = WorkerFeedback.new(feedback_params)
        @worker = Worker.find(params[:worker_id])
        if already_feedback
            redirect_to @worker
            return
        end

        @feedback.worker = @worker
        @feedback.hirer = current_hirer

        if @feedback.save
            redirect_to @worker, notice: t('feedbacks.create.submit_success')
        else
            render :new
        end
    end

    private
    def already_feedback
        not @worker.worker_feedbacks.where(hirer: current_hirer).empty?
    end

    def feedback_params 
        params.require(:worker_feedback).permit(
            :score, :comment
        )
    end
end