class Hirer < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  validates :username, presence: true, uniqueness: true

  has_many :projects
  has_many :project_applications, through: :projects

  has_many :hirer_feedbacks
  has_many :worker_feedbacks

  has_many :favorited_workers

  def get_feedback_by(worker)
    query_results = hirer_feedbacks.where(worker: worker)
    if query_results.any? 
      return query_results[0]
    end
  end

  def favorited_by?(worker)
    if worker
      worker.favorited_hirers.where(:hirer => self).any?
    end
  end
end
