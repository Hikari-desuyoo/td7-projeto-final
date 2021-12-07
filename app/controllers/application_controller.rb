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

    def find(model_class)
        model_class.find(params[:id])
    end

    def authenticate_project_application_worker(project_application)
        return if current_worker == project_application.worker
        redirect_to root_path
    end


    def authenticate_project_application_hirer(project_application)
        return if current_hirer == project_application.project.hirer
        redirect_to root_path
    end

    def authenticate_project_application_user(project_application)
        return authenticate_project_application_worker(project_application) if current_worker
        authenticate_project_application_hirer(project_application)
    end

    def authenticate_complete_worker!
        unless current_worker&.complete_profile?
          redirect_to root_path
        end
      end
end
