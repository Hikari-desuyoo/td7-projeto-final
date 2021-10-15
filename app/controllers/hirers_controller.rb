class HirersController < ApplicationController
    def show
        @hirer = Hirer.find(params[:id])

        set_feedback_attributes
        set_favorite_attributes
    end

    private
    def set_feedback_attributes
        @hirer_average_score = @hirer.hirer_feedbacks.average(:score)

        @your_feedback = false
        @feedbacks = @hirer.hirer_feedbacks
        
        if worker_signed_in?
            feedback_query = current_worker.hirer_feedbacks.where(:hirer => @hirer)
            unless feedback_query.empty?
                @your_feedback = feedback_query[0]
            end
        end

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