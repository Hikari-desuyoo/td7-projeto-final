class WorkerFeedback < ApplicationRecord
    belongs_to :hirer
    belongs_to :worker

    validates :score, score: true

    validate :hirer_and_worker_involved 
    private
    def hirer_and_worker_involved
        zero_feedbacks = worker.worker_feedbacks.where(hirer: hirer).empty?
        #There's probably a better way to do this
        involved = worker.get_feedbackable_project_id.intersection(hirer.projects.pluck(:id)).any?
        
        if not (zero_feedbacks and involved)
            errors.add(:hirer, "not involved")
        end
    end
end
