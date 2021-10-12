class ProjectApplication < ApplicationRecord
  belongs_to :worker
  belongs_to :project

  enum status: { declined: 0, pending: 10, accepted: 20 }
end
