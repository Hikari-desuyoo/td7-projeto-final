class ProjectApplicationMailer < ApplicationMailer
  def notify_new_project_application
    @project_application = params[:project_application]
    @hirer = @project_application.project.hirer
    mail(to: @hirer.email,
         subject: 'Nova proposta para seu projeto')
  end
end
