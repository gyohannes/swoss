class User < ApplicationRecord
  belongs_to :hospital
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  ROLES = [ADMINISTRATOR='Administrator', LIAISON_OFFICER='Liaison Officer', OR_USER='Operating Room']

  def is_role(given_role)
    role == given_role
  end

  def to_s
    user_name
  end

end
