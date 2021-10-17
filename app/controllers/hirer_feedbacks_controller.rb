class HirerFeedbacksController < ApplicationController
    before_action :authenticate_worker!
    def new
        @hirer = Hirer.find(params[:hirer_id])
        @feedback = HirerFeedback.new()
    end

    def create
        @feedback = HirerFeedback.new(feedback_params)
        @hirer = Hirer.find(params[:hirer_id])
        if already_feedback
            redirect_to @hirer
            return
        end
        @feedback.hirer = @hirer
        @feedback.worker = current_worker

        if @feedback.save
            redirect_to @hirer, notice: t('feedbacks.create.submit_success')
        else
            render :new
        end
    end

    private
    def already_feedback
        not @hirer.hirer_feedbacks.where(worker: current_worker).empty?
    end

    def feedback_params 
        params.require(:hirer_feedback).permit(
            :score, :comment
        )
    end
end