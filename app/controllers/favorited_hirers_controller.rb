class FavoritedHirersController < ApplicationController
    before_action :authenticate_worker!
    def favorite 
        hirer = Hirer.find(params[:id])
        FavoritedHirer.create(
            hirer: hirer,
            worker: current_worker
        )
        
        redirect_to hirer
    end

    def unfavorite
    end
end