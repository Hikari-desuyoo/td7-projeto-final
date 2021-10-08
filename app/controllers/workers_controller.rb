class WorkersController < ApplicationController
    def update
        @current_worker = Worker.find(params[:id])
        @current_worker.update(worker_params)

        unless @current_worker.complete_profile?
            flash[:notice] = t('.profile_still_incomplete')
        end

        redirect_to root_path

    end

    private
    def worker_params
        params.require(:worker).permit(
            :full_name,
            :social_name,
            :birth_date,
            :education,
            :description,
            :experience
        )
    end
end