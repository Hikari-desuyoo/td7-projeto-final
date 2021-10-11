class HomeController < ApplicationController
    def index
        if worker_signed_in?
            @current_worker = current_worker
            @occupations = Occupation.all
            @projects = Project.all
        end
    end
end