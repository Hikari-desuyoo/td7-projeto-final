class SearchController < ApplicationController
  before_action :authenticate_user

  def search
    if worker_signed_in?
      @results = search_projects
      only_open_project_results
    else
      @results = search_workers
    end
  end

  private

  def only_open_project_results
    @results = @results.where(
      status: 'open'
    ).where(
      'open_until >= ?', Date.today
    )
  end

  def get_search_term
    @search_term = params[:search_term].gsub(/['"]/, '')
  end

  def search_projects
    get_search_term

    Project.where('title like ?', "%#{@search_term}%").or(
      Project.where('description like ?', "%#{@search_term}%")
    ).or(
      Project.where('skills_needed like ?', "%#{@search_term}%")
    )
  end

  def search_workers
    get_search_term

    Worker.where('name like ?', "%#{@search_term}%").or(
      Worker.where('surname like ?', "%#{@search_term}%")
    ).or(
      Worker.where('social_name like ?', "%#{@search_term}%")
    )
  end

  def authenticate_user
    unless hirer_signed_in? or worker_signed_in?
      redirect_to '/'
    end
  end
end
