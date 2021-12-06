class ApplicationController < ActionController::Base
    before_action :redirect_incomplete_workers

    private 
    def redirect_incomplete_workers
        return unless current_worker&.incomplete_profile?
        
        redirect_to root_path, alert: t('alert.profile_still_incomplete')
    end

    def authenticate_right_worker!
        unless worker_signed_in? and (current_worker == Worker.find(params[:id]))
          redirect_to root_path
        end
    end
end
