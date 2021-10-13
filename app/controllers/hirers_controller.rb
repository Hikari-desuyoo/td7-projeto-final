class HirersController < ApplicationController
    def show
        @hirer = Hirer.find(params[:id])

        @hirer_average_score = @hirer.worker_feedbacks.average(:score)

        @feedback = false
        @show_feedback_button = false
        if worker_signed_in?
            feedback_query = current_worker.hirer_feedbacks.where(:worker => @hirer)
            unless feedback_query.empty?
                @feedback = feedback_query[0]
            else
                @show_feedback_button = true
            end

        end

        if @hirer_average_score == nil then @hirer_average_score = '-' end

    end

end