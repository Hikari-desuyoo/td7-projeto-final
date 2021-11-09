class HomeController < ApplicationController
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
    @projects = Project.all
    only_open_projects
  end

  def hirer_index
    @applications = current_hirer.project_applications
  end

  def only_open_projects
    @projects = @projects.select { |project| project.status == 'open' }
  end
end
