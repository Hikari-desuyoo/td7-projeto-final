class ProjectFeedbacksController < ApplicationController
  before_action :authenticate_worker!
  def new
    @project = Project.find(params[:project_id])
    @feedback = ProjectFeedback.new()
  end

  def create
    @feedback = ProjectFeedback.new(feedback_params)
    @project = Project.find(params[:project_id])
    if cant_feedback
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
  def cant_feedback
    zero_feedbacks = @project.project_feedbacks.where(worker: current_worker).empty?
    # There's probably a better way to do this
    involved = current_worker.get_feedbackable_project_id.include? @project.id

    not (zero_feedbacks and involved)
  end

  def feedback_params
    params.require(:project_feedback).permit(
      :score, :comment
    )
  end
end
