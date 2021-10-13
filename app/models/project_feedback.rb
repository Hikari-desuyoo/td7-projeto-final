class ProjectFeedback < ApplicationRecord
  belongs_to :project
  belongs_to :worker

  validates :score, score: true
end
