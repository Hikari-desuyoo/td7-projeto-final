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


    def get_accepted_applications
        project_applications.where(status: 'accepted')
    end

    def get_team
        accepted = get_accepted_applications
        Worker.where(id: accepted.pluck(:worker_id).uniq)
    end

    def is_worker_involved?(worker)
        worker_search_results = project_applications.where(worker_id: worker.id)
        worker_search_results.any?
    end

    def can_apply?(worker)
        if worker == nil then return false end
        is_open = open?
        worker_not_involved = not(is_worker_involved?(worker))
        is_open and worker_not_involved
    end
    

    #STATUS RELATED    
    def status
        if self[:status] == 'open' and  open_until < Date.today
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
            errors.add(:open_until, "já passou")
        end
    end
end
