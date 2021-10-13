class WorkerFeedbacksController < ApplicationController
    before_action :authorize_hirer_access
    def new
        @feedback = WorkerFeedback.new()
    end

    def create
        @feedback = WorkerFeedback.new(feedback_params)
        @worker = Worker.find(params[:worker_id])
        @feedback.worker = @worker
        @feedback.hirer = current_hirer

        if @feedback.save
            redirect_to @worker, notice: t('.submit_success')
        else
            render :new
        end
    end

    private
    def authorize_hirer_access
    end

    def feedback_params 
        params.require(:worker_feedback).permit(
            :score, :comment
        )
    end
end