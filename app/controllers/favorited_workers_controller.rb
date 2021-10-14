class FavoritedWorkersController < ApplicationController
    before_action :authenticate_hirer!
    def favorite 
        worker = Worker.find(params[:id])
        FavoritedWorker.create(
            worker: worker,
            hirer: current_hirer
        )
        
        redirect_to worker
    end

    def unfavorite
    end
end