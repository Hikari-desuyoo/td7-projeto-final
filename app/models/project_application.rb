class ProjectApplication < ApplicationRecord
  belongs_to :worker
  belongs_to :project

  enum status: { rejected: 0, pending: 10, accepted: 20 }
end
