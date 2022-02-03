class WorkerReportWorker
  include Sidekiq::Worker

  def perform(json_params, _count)
    json_params = JSON.parse(json_params)
    WorkerReport.find(json_params['worker_report_id']).refresh
  end
end
