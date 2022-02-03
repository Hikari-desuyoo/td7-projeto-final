class ProjectApplicationMailerWorker
  include Sidekiq::Worker

  def perform(json_params, _count)
    json_params = JSON.parse(json_params)
    ProjectApplicationMailer.notify_new_project_application(json_params['project_application_id']).deliver
  end
end
