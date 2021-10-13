class ProjectFeedback < ApplicationRecord
  belongs_to :project
  belongs_to :worker

  validate :score_valid
  private
  def score_valid
      valid_range = 0..5
      if not valid_range.include?(score)
      errors.add(:score, "invalid_score")
      end
  end
end
