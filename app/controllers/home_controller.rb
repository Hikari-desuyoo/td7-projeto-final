class HomeController < ApplicationController
    def index
        if worker_signed_in?
            @current_worker = current_worker
        end
    end
end