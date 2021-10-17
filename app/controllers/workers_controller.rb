class WorkersController < ApplicationController
    before_action :authenticate_right_worker!, only: [:edit ,:update]

    def complete_profile
        unless worker_signed_in?
            redirect_to root_path
            return
        end

        @current_worker = current_worker
        @current_worker.update(worker_params)

        unless @current_worker.complete_profile?
            redirect_to root_path, alert: t('alert.profile_still_incomplete')
            return
        end

        redirect_to root_path
    end

    def show
        @worker = Worker.find(params[:id])
        unless @worker.complete_profile?
            if current_worker then flash[:alert] = t 'alert.profile_still_incomplete' end
            redirect_to root_path
            return
        end

        set_feedback_attributes
        set_favorite_attributes
    end

    def edit
        @occupations = Occupation.all
        @current_worker = current_worker
    end

    def update
        @current_worker = current_worker
        @current_worker.update(edit_worker_params)

        redirect_to @current_worker
    end

    private
    def authenticate_right_worker!
        unless worker_signed_in? and (current_worker == Worker.find(params[:id]))
            redirect_to root_path
        end
    end

    def set_feedback_attributes
        @worker_average_score = @worker.worker_feedbacks.average(:score)

        @your_feedback = false
        @feedbacks = @worker.worker_feedbacks
        
        if hirer_signed_in?
            feedback_query = current_hirer.worker_feedbacks.where(:worker => @worker)
            unless feedback_query.empty?
                @your_feedback = feedback_query[0]
            end

        end

        if @worker_average_score == nil then @worker_average_score = '-' end
    end

    def set_favorite_attributes
        @show_favorite_button = false
        @show_unfavorite_button = false
        

        if hirer_signed_in?
            if current_hirer.favorited_workers.where(:worker => @worker).empty?
                @show_favorite_button = true
            else
                @show_unfavorite_button = true
            end
        end
    end

    def edit_worker_params
        params.require(:worker).permit(
            :education,
            :description,
            :experience,
            :occupation_id
        )
    end

    def worker_params
        params.require(:worker).permit(
            :name,
            :surname,
            :social_name,
            :birth_date,
            :education,
            :description,
            :experience,
            :occupation_id
        )
    end
end