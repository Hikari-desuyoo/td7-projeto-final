class Worker < ApplicationRecordUser
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  belongs_to :occupation, optional: true

  validates :name,
            :surname,
            :birth_date,
            :occupation_id,
            presence: true, on: :update

  has_many :project_applications
  has_many :projects, through: :project_applications, dependent: :destroy
  has_many :hirer_feedbacks
  has_many :worker_feedbacks
  has_many :project_feedbacks

  has_many :favorited_hirers
  has_one :worker_report

  after_create :initialize_worker_report

  def initialize_worker_report
    self.worker_report = WorkerReport.create!(
      worker: self
    )
  end

  def complete_profile?
    !incomplete_profile?
  end

  def incomplete_profile?
    name.blank? ||
      surname.blank? ||
      birth_date.blank?
  end

  def get_name
    social_name.presence || name
  end

  def get_full_name
    "#{get_name} #{surname}"
  end

  def get_feedbackable_project_id
    project_applications.where(status: 'accepted').pluck(:project_id)
  end

  def gave_project_feedback?(project)
    feedback_query = project_feedbacks.where(project: project)
    feedback_query.any?
  end

  def human_occupation_name
    I18n.t("occupation_name.#{occupation.name}")
  end

  def favorited_by?(hirer)
    if hirer
      hirer.favorited_workers.where(worker: self).any?
    end
  end

  def get_feedback_by(hirer)
    query_results = worker_feedbacks.where(hirer: hirer)
    if query_results.any?
      query_results[0]
    end
  end
end
