class HirersController < ApplicationController
    def show
        @hirer = Hirer.find(params[:id])

        @hirer_average_score = @hirer.worker_feedbacks.average(:score)

        @feedback = false
        
        if worker_signed_in?
            feedback_query = current_worker.hirer_feedbacks.where(:hirer => @hirer)
            unless feedback_query.empty?
                @feedback = feedback_query[0]
            end
        end

        if @hirer_average_score == nil then @hirer_average_score = '-' end

    end

end