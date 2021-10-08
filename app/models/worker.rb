class Worker < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  belongs_to :occupation, optional: true

  def complete_profile?
    not (
      full_name.blank? or
      birth_date.blank?
    )
  end
end
