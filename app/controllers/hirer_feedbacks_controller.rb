class HirerFeedbacksController < ApplicationController
    before_action :authenticate_worker!
    def new
        @hirer = Hirer.find(params[:hirer_id])
        @feedback = HirerFeedback.new()
    end

    def create
        @feedback = HirerFeedback.new(feedback_params)
        @hirer = Hirer.find(params[:hirer_id])
        if cant_feedback
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
    def cant_feedback
        zero_feedbacks = @hirer.hirer_feedbacks.where(worker: current_worker).empty? 
        #There's probably a better way to do this
        involved = current_worker.get_feedbackable_project_id.intersection(@hirer.projects.pluck(:id)).any?
        
        not (zero_feedbacks and involved)
    end

    def feedback_params 
        params.require(:hirer_feedback).permit(
            :score, :comment
        )
    end
end