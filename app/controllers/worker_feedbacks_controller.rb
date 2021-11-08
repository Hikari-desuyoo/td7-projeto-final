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
  def feedback_params
    params.require(:worker_feedback).permit(
      :score, :comment
    )
  end
end
