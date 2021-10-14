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
        hirer = Hirer.find(params[:id])
        
        FavoritedHirer.where(
            hirer: hirer,
            worker: current_worker
        )[0].destroy
        
        redirect_to hirer
    end
end