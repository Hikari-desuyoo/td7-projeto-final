class ProjectApplicationMailer < ApplicationMailer
  def notify_new_project_application(project_application_id)
    @project_application = ProjectApplication.find(project_application_id)
    @hirer = @project_application.project.hirer
    mail(to: @hirer.email,
         subject: 'Nova proposta para seu projeto')
  end
end
