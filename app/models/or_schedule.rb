class OrSchedule < ApplicationRecord
  belongs_to :user
  belongs_to :admission
  belongs_to :surgeon
  belongs_to :anesthesian
  belongs_to :scrub_nurse
  belongs_to :circulating_nurse
  belongs_to :schedule_order
  has_one :surgical_service
  before_save :set_gregorian_dates

  def set_gregorian_dates
    self[:scheduled_date_gr] = Services::EthioGregorianDates.set_gregorian(self.scheduled_date, '/')
  end

  def self.elective_procedures_scheduled(department, from, to)
    joins(:admission).where('department_id = ? and admission_type = ? and scheduled_date_gr >= ? and scheduled_date_gr <= ?',
                            department, Constants::ELECTIVE, from, to).count
  end

end
