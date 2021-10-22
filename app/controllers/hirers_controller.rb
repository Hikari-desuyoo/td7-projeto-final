class HirersController < ApplicationController
    def show
        @hirer = Hirer.find(params[:id])

        set_feedback_attributes
        set_favorite_attributes
    end

    private
    def set_feedback_attributes
        @hirer_average_score = @hirer.hirer_feedbacks.average(:score)

        @your_feedback = @hirer.get_feedback_by current_worker
        @feedbacks = @hirer.hirer_feedbacks

        if @hirer_average_score == nil then @hirer_average_score = '-' end
    end

    def set_favorite_attributes
        @show_favorite_button = false
        @show_unfavorite_button = false
        
        if worker_signed_in?
            if current_worker.favorited_hirers.where(:hirer => @hirer).empty?
                @show_favorite_button = true
            else
                @show_unfavorite_button = true
            end
        end
    end

end