class CirculatingNurse < ApplicationRecord
  belongs_to :hospital

  def to_s
    name
  end
end
