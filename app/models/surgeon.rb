class Surgeon < ApplicationRecord
  belongs_to :hospital
  belongs_to :occupation_group

  validates :name, presence: true

  def to_s
    name
  end
end
