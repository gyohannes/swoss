class ProcedureCategory < ApplicationRecord
  has_many :procedures
  has_many :admissions, through: :procedures

  validates :code, :max_appointment_days, :max_postponment_days, presence: true

  def waitlist
    admissions.where('status = ?', Constants::ON_WAITING_LIST).count
  end

  def to_s
    code.to_s
  end

end
