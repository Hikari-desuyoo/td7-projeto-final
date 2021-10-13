class Hirer < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  validates :username, presence: true, uniqueness: true

  has_many :projects
  has_many :worker_feedbacks
  has_many :project_applications, through: :projects

  has_many :hirer_feedbacks
end
