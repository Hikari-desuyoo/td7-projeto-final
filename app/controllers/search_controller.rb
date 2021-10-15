class SearchController < ApplicationController
    before_action :authenticate_user

    def search
        @results = search_projects
        only_open_project_results        
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

        results = Project.where(
            'title like ?', "%#{@search_term}%"
        )

        results = results.or(
            Project.where(
                'description like ?', "%#{@search_term}%"
            )
        )

        results = results.or(
            Project.where(
                'skills_needed like ?', "%#{@search_term}%"
            )
        )


        return results
    end

    def authenticate_user
        unless hirer_signed_in? or worker_signed_in? 
            redirect_to '/' 
        end
    end

end