class WorkersController < ApplicationController
    def complete_profile
        @current_worker = current_worker
        @current_worker.update(worker_params)

        unless @current_worker.complete_profile?
            flash[:alert] = t 'alert.profile_still_incomplete'
        end

        redirect_to root_path
    end

    private
    def worker_params
        params.require(:worker).permit(
            :name,
            :surname,
            :social_name,
            :birth_date,
            :education,
            :description,
            :experience
        )
    end
end