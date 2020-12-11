class OrSchedule < ApplicationRecord
  belongs_to :user
  belongs_to :admission
  belongs_to :surgeon
  belongs_to :anesthesian
  belongs_to :scrub_nurse
  belongs_to :circulating_nurse
  belongs_to :schedule_order, optional: true
  belongs_to :or_block
  belongs_to :or_table
  has_one :surgical_service, dependent: :destroy

  before_save :set_gregorian_dates

  before_save :remove_blank_assisstant_surgeons

  def remove_blank_assisstant_surgeons
    assisstant_surgeons.reject!(&:blank?)
  end

  def set_gregorian_dates
    self[:scheduled_date_gr] = Services::EthioGregorianDates.set_gregorian(self.scheduled_date, '/')
  end

  def self.elective_procedures_scheduled(department, from, to)
    joins(:admission).where('department_id = ? and admission_type = ? and scheduled_date_gr >= ? and scheduled_date_gr <= ?',
                            department, Constants::ELECTIVE, from, to).count
  end

end
