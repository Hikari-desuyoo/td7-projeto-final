class HomeController < ApplicationController
    def index
        if worker_signed_in?
            @current_worker = current_worker
            @occupations = Occupation.all
            @projects = Project.all
            only_open_projects
        end
    end

    private
    def only_open_projects
        @projects = @projects.select { |project|
            project.status == 'open'
        }
    end
end