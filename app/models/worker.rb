class Worker < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  belongs_to :occupation, optional: true

  validates :name, 
            :surname,
            :social_name,
            :birth_date,
            presence: true, on: :update

  has_many :project_applications
  has_many :projects, through: :project_applications
  has_many :hirer_feedbacks
  has_many :worker_feedbacks
  has_many :project_feedbacks

  has_many :favorited_hirers

  def complete_profile?
    not (
      name.blank? or
      surname.blank? or
      birth_date.blank?
    )
  end

  def get_name
    social_name.blank? ? name : social_name
  end

  def get_full_name
    get_name + surname
  end

  def get_feedbackable_project_id
    project_applications.where(status: 'accepted').pluck(:project_id)
  end
end
