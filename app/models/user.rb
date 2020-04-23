class User < ApplicationRecord
  belongs_to :hospital
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  ROLES = [ADMINISTRATOR='Administrator', OR_MANAGER='OR Manager', LIAISON_OFFICER='Liaison Officer', OR_USER='OR User']

  def is_role(given_role)
    role == given_role
  end

  def to_s
    user_name
  end

end
