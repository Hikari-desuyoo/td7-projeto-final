class WorkerReport < ApplicationRecord
  belongs_to :worker, optional: true
  belongs_to :best_scored_project, class_name: 'Project', optional: true
  belongs_to :worst_scored_project, class_name: 'Project', optional: true

  enum status: { processed: 0, processing: 10 }

  def start_refresh_job
    processing!
    h = JSON.generate({ worker_report_id: id })
    WorkerReportWorker.perform_async(h, 1)
  end

  def refresh
    refresh_date
    self.project_count = worker.projects.count
    refresh_project_score_records
    processed!
    save!
  end

  def refresh_date
    self.last_refresh_at = DateTime.now
  end

  def refresh_project_score_records
    worst_scored_project = best_scored_project = nil
    worst_project_score = 11
    best_project_score = 0

    worker.projects.each do |project|
      project_score = project.get_average_score
      next if project_score.nil?

      if project_score > best_project_score
        best_project_score = project_score
        best_scored_project = project

      elsif project_score < worst_project_score
        worst_project_score = project_score
        worst_scored_project = project
      end
    end

    self.worst_scored_project = worst_scored_project
    self.best_scored_project = best_scored_project
  end
end
