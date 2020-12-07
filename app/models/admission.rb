class Admission < ApplicationRecord
  belongs_to :user
  belongs_to :patient
  belongs_to :diagnosis
  belongs_to :procedure
  belongs_to :physician
  belongs_to :department, optional: true
  belongs_to :ward, optional: true
  belongs_to :payment_type, optional: true
  has_many :phone_calls
  has_many :admission_statuses, dependent: :destroy
  has_many :or_schedules
  before_save :set_gregorian_dates
  validates :date_of_registration, :admission_type, presence: true
  validates :listing_status, :appointment_date, :payment_type_id, presence: true, if: :elective
  validates :department_id, :admission_date, :ward_id, presence: true, if: :emergency

  def elective
    admission_type == Constants::ELECTIVE
  end

  def emergency
    admission_type == Constants::EMERGENCY_NEW || admission_type == Constants::EMERGENCY_REOPERATION
  end

  def set_gregorian_dates
    self[:appointment_date_gr] = Services::EthioGregorianDates.set_gregorian(self.appointment_date, '/')
    self[:admission_date_gr] = Services::EthioGregorianDates.set_gregorian(self.admission_date, '/')
    self[:date_of_registration_gr] = Services::EthioGregorianDates.set_gregorian(self.date_of_registration, '/')
  end

  def self.waiting_total(status)
    return Admission.where('status = ?', status).count
  end

  def self.waiting_month_total(status, month)
    eth_month = fromGregorianToEthiopic(month.year, month.month, month.day)
    year_month_day = eth_month.split('-')
    eth_month = year_month_day[1] + '/' + year_month_day[0]
    from = Services::EthioGregorianDates.eth_month_reporting_start(eth_month)
    to = Services::EthioGregorianDates.eth_month_reporting_end(eth_month)
    joins(:admission_statuses).where('admission_statuses.status = ? and admission_statuses.status_date >= ? and admission_statuses.status_date <= ?', status, from,to).count
  end

  def self.appointed_for_next(days)
    where('status = ? and appointment_date_gr <= ?', Constants::ON_WAITING_LIST, Date.today + days.days)
  end


  def self.elective_admissions(department, from, to)
    where('department_id = ? and admission_type = ? and date_of_registration_gr >= ? and date_of_registration_gr <= ?',
          department, Constants::ELECTIVE, from, to)
  end

  def days_between_reg_and_admission
    (admission_date_gr - registration_date_gr).to_i rescue nil
  end

  def self.admissions(from, to)
    where('date_of_registration_gr >= ? and date_of_registration_gr <= ?', from, to)
  end

  def priority_status
    priority == true ? 'Yes' : 'No'
  end

  def to_s
    patient
  end
end
