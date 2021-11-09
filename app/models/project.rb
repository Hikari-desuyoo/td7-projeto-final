class Project < ApplicationRecord
  validates :title, :description, :skills_needed,
            :max_pay_per_hour, :open_until,
            presence: true

  validates :max_pay_per_hour, numericality: true
  validate :valid_close_date, on: :create

  belongs_to :hirer

  has_many :project_applications, dependent: :destroy

  enum status: { open: 0, closed: 10, finished: 20 }
  has_many :project_feedbacks

  has_many :accepted_applications, -> { where status: 'accepted' },
      class_name: 'ProjectApplication'

  has_many :workers, through: :accepted_applications

  def get_i18n_status
    I18n.t("projects.show.#{status}_project")
  end

  def get_average_score
    project_feedbacks.average(:score)
  end

  # GENERAL AUTHENTICATION RELATED
  def member?(hirer_or_worker)
    owner?(hirer_or_worker) or team_member?(hirer_or_worker)
  end

  def can_feedback_member?(hirer_or_worker)
    hirer_or_worker and finished? and member?(hirer_or_worker)
  end

  # HIRER AUTHENTICATION RELATED
  def owner?(received_hirer)
    hirer == received_hirer
  end

  # WORKER AUTHENTICATION RELATED
  def team_member?(worker)
    workers.include?(worker)
  end

  def worker_involved?(worker)
    if worker
      worker_search_results = project_applications.where(worker_id: worker.id)
      worker_search_results.any?
    end
  end

  def can_apply?(worker)
    if worker
      is_open = open?
      worker_not_involved = not(worker_involved?(worker))
      is_open and worker_not_involved
    end
  end

  def applied?(worker)
    if worker
      project_applications.where(worker: worker).any?
    end
  end

  def can_feedback?(worker)
    if worker
      finished? and not worker.gave_project_feedback?(self)
    end
  end

  def get_feedback(worker)
    if worker
      worker.project_feedbacks.where(project: self)[0]
    end
  end

  def get_application(worker)
    if worker
      query_results = project_applications.where(worker: worker)
      if query_results.empty? then return false end

      query_results[0]
    end
  end

  # STATUS RELATED
  def status
    if self[:status] == 'open' and open_until < Date.today
      closed!
    end

    self[:status]
  end

  def closed?
    status == 'closed'
  end

  def open?
    status == 'open'
  end

  private

  def valid_close_date
    return if open_until.blank?

    if open_until < Date.today
      errors.add(:open_until, 'já passou')
    end
  end
end
