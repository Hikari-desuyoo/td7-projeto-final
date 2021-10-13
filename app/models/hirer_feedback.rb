class HirerFeedback < ApplicationRecord
    belongs_to :hirer
    belongs_to :worker

    validates :score, score: true
end