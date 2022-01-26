class ProjectApplicationsController < ApplicationController
  before_action :authenticate_complete_worker!, only: %i[create cancel]
  before_action only: %i[cancel accept decline show] do
    @project_application = find(ProjectApplication)
  end

  before_action only: %i[cancel] do
    authenticate_project_application_worker @project_application
  end

  before_action only: %i[accept decline] do
    authenticate_project_application_hirer @project_application
  end

  before_action only: %i[show] do
    authenticate_project_application_user @project_application
  end

  # NOT NESTED ON PROJECT ROUTES
  def show; end

  def my_project_applications
    if hirer_signed_in?
      @signed_user = 'hirer'
      @project_applications = current_hirer.project_applications
    elsif worker_signed_in?
      @signed_user = 'worker'
      @project_applications = current_worker.project_applications
    end
  end

  # NESTED ON PROJECT ROUTES
  def create
    @project = Project.find(params[:project_id])

    description = params[:description]

    if current_worker.projects.include?(@project)
      redirect_to root_path
      return
    end

    @project_application = ProjectApplication.new(
      project: @project,
      worker: current_worker,
      description: description
    )

    if @project_application.save
      redirect_to @project, notice: t('.success')
    else
      redirect_to @project, notice: t('.failed')
    end
  end

  def accept
    @project_application = ProjectApplication.find(params[:id])
    @project_application.accepted!
    if @project_application.accepted?
      redirect_to @project_application, notice: t('.success_notice')
    end
  end

  def decline
    @project_application = ProjectApplication.find(params[:id])
    @project_application.declined!
    decline_params = params.require(:project_application).permit(
      :decline_reason
    )

    @project_application.update!(decline_params)
    if @project_application.declined?
      redirect_to @project_application, notice: t('.success_notice')
    end
  end

  def cancel
    @project_application = ProjectApplication.find(params[:id])
    if @project_application.pending?
      @project_application.destroy
    end

    redirect_to my_project_applications_project_applications_path, notice: t('.success_notice')
  end
end
