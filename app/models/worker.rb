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
end
