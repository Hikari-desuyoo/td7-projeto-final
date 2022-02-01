class ProjectApplicationMailerWorker
  include Sidekiq::Worker

  def perform(h, _count)
    h = JSON.load(h)
    ProjectApplicationMailer.notify_new_project_application(h['project_application_id']).deliver
  end
end
