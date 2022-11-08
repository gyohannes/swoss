class Bed < ApplicationRecord
  belongs_to :ward
  has_many :admissions

  validates :block, :floor, :bed_number, presence: true
  validates :bed_number, uniqueness: { scope: :ward_id }

  def bed_status
    status == true ? 'Occupied' : 'Free'
  end

  def current_admission
    admissions.where(status: Constants::ADMITTED).first
  end

  def to_s
    bed_number
  end

end
