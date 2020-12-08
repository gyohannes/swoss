class Surgeon < ApplicationRecord
  belongs_to :hospital
  belongs_to :occupation_group

  def to_s
    name
  end
end
