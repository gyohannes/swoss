class Surgeon < ApplicationRecord
  default_scope -> {where(status: true)}

  belongs_to :hospital
  belongs_to :occupation_group

  validates :name, presence: true

  def surgeon_status
    status == true ? 'Active' : 'Disabled'
  end

  def to_s
    name
  end
end
