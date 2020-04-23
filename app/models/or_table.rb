class OrTable < ApplicationRecord
  belongs_to :hospital

  def to_s
    name
  end

end
