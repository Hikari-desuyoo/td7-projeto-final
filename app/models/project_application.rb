class ProjectApplication < ApplicationRecord
  belongs_to :worker
  belongs_to :project

  enum status: { declined: 0, pending: 10, accepted: 20 }

  def can_worker_cancel?(worker)
    if worker
      pending?
    end
  end
end
