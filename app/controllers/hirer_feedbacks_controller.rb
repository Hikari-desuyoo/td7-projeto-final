class HirerFeedbacksController < ApplicationController
    before_action :authenticate_worker!
    def new
        @hirer = Hirer.find(params[:hirer_id])
        @feedback = HirerFeedback.new()
    end

    def create
        @feedback = HirerFeedback.new(feedback_params)
        @hirer = Hirer.find(params[:hirer_id])

        @feedback.hirer = @hirer
        @feedback.worker = current_worker

        if @feedback.save
            redirect_to @hirer, notice: t('feedbacks.create.submit_success')
        else
            redirect_to @hirer
        end
    end

    private
    def feedback_params 
        params.require(:hirer_feedback).permit(
            :score, :comment
        )
    end
end