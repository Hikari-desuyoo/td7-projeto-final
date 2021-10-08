class Project < ApplicationRecord
    validates :title, :description, :skills_needed, 
              :max_pay_per_hour, :open_until, 
              presence: true

    validates :max_pay_per_hour, numericality: true
    validate :valid_close_date

    belongs_to :hirer

    private

    def valid_close_date
        return if open_until.blank?

        if open_until < Date.today
            errors.add(:open_until, "já passou")
        end
    end
end