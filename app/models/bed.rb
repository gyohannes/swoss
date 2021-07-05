class Bed < ApplicationRecord
  belongs_to :ward

  validates :block, :floor, :bed_number, presence: true

  def bed_status
    status == true ? 'Occupied' : 'Free'
  end

  def to_s
    bed_number
  end

end
