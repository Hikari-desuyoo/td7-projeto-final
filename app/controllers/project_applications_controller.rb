 class ProjectApplicationsController < ApplicationController
   before_action :authenticate_worker!, only: %i[create cancel]
   before_action :authenticate_complete_worker!, only: %i[create cancel]
   before_action :authenticate_hirer!, only: %i[accept decline]

   # NOT NESTED ON PROJECT ROUTES
   def show
     @project_application = ProjectApplication.find(params[:id])
     application_from_linked_users_authetication!
   end

   def my_project_applications
     if hirer_signed_in?
       @signed_user = 'hirer'
       @project_applications = current_hirer.project_applications
     elsif worker_signed_in?
       @signed_user = 'worker'
       @project_applications = current_worker.project_applications
     end
   end

   # NESTED ON PROJECT ROUTES
   def create
     @project = Project.find(params[:project_id])

     description = params[:description]

     if current_worker.projects.include?(@project)
       redirect_to root_path
       return
     end

     @project_application = ProjectApplication.new(
       project: @project,
       worker: current_worker,
       description: description
     )

     if @project_application.save
       redirect_to @project, notice: t('.success')
     else
       redirect_to @project, notice: t('.failed')
     end
   end

   def accept
     @project_application = ProjectApplication.find(params[:id])
     @project_application.accepted!
     if @project_application.accepted?
       redirect_to @project_application, notice: t('.success_notice')
     end
   end

   def decline
     @project_application = ProjectApplication.find(params[:id])
     @project_application.declined!
     decline_params = params.require(:project_application).permit(
       :decline_reason
     )

     @project_application.update!(decline_params)
     if @project_application.declined?
       redirect_to @project_application, notice: t('.success_notice')
     end
   end

   def cancel
     @project_application = ProjectApplication.find(params[:id])
     if @project_application.pending?
       @project_application.destroy
     end

     redirect_to my_project_applications_project_applications_path, notice: t('.success_notice')
   end

    private
   def application_for_current_hirer!
     if hirer_signed_in? and current_hirer != @project_application.project.hirer
       redirect_to root_path
     end
   end

   def application_from_current_worker!
     if worker_signed_in? and current_worker != @project_application.worker
       redirect_to root_path
     end
   end

   def application_from_linked_users_authetication!
     application_for_current_hirer!
     application_from_current_worker!
   end

   def authenticate_complete_worker!
     unless current_worker.complete_profile?
       redirect_to root_path
     end
   end
 end
