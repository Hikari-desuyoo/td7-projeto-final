class Project < ApplicationRecord
    validates :title, :description, :skills_needed, 
              :max_pay_per_hour, :open_until, 
              presence: true

    belongs_to :hirer
end
