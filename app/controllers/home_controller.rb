class HomeController < ApplicationController
  skip_before_action :redirect_incomplete_workers, only: [:index]

  def index
    if worker_signed_in?
      worker_index
    elsif hirer_signed_in?
      hirer_index
    end
  end

  private

  def worker_index
    @current_worker = current_worker
    @occupations = Occupation.all
    @projects = only_open_projects
  end

  def hirer_index
    @applications = current_hirer.project_applications
  end

  def only_open_projects
    projects = Project.all
    projects.select { |project| project.status == 'open' }
  end
end
