class ProjectsController < ApplicationController
  before_action :authenticate_hirer!, only: %i[new create my_projects]

  def new
    @project = Project.new
  end

  def create
    @project = Project.new(project_params)
    @project.hirer = current_hirer

    if @project.save
      redirect_to @project
    else
      render :new
    end
  end

  def show
    @project = Project.find(params[:id])
    @owner_signed_in = @project.owner? current_hirer
    @project_team = @project.workers
    @member_signed_in = (@owner_signed_in or @project.team_member?(current_worker))

    @project_application = @project.get_application(current_worker)
    @project_status = @project.get_i18n_status

    set_feedback_attributes
  end

  def finish
    @project = Project.find(params[:id])
    if project_owner?
      @project.finished!
    end

    redirect_to @project
  end

  def close
    @project = Project.find(params[:id])
    if project_owner?
      @project.closed!
    end

    redirect_to @project
  end

  def my_projects
    @projects = current_hirer.projects
  end

    private
  def set_feedback_attributes
    @project_average_score = @project.get_average_score
    @feedbacks = @project.project_feedbacks
    @your_feedback = @project.get_feedback(current_worker)

    if @project_average_score == nil then @project_average_score = '-' end
  end

  def project_params
    params.require(:project).permit(
      :title, :description, :skills_needed,
        :max_pay_per_hour, :open_until, :remote,
        :presential
    )
  end

  def project_owner?
    @project.hirer == current_hirer
  end
end
