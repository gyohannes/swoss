class Admission < ApplicationRecord
  belongs_to :user
  belongs_to :patient
  belongs_to :diagnosis
  belongs_to :procedure
  belongs_to :procedure_category
  belongs_to :physician
  belongs_to :department
  belongs_to :ward, optional: true
  belongs_to :bed, optional: true
  belongs_to :payment_type, optional: true
  has_many :phone_calls, dependent: :destroy
  has_many :admission_statuses, dependent: :destroy
  has_many :or_schedules, dependent: :destroy

  validates :date_of_registration, :admission_type, :department_id, presence: true
  validates :listing_status, :appointment_date, :payment_type_id, presence: true, if: :elective
  validates :admission_date, :admission_time, :ward_id, :bed_id, presence: true, if: :emergency

  before_save :set_gregorian_dates
  after_save :occupy_bed
  after_save :set_admission_time

  scope :list_by_mrn, -> (mrn) { joins(:patient).where('mrn = ?', mrn) unless mrn.blank? }
  scope :list_by_department, -> (department) { where("department_id = ?", department) unless department.blank? }

  def latest_status
    admission_statuses.order('status_date DESC').first
  end

  def latest_schedule
    or_schedules.order('created_at DESC').first
  end

  def self.search(mrn=nil, department=nil)
    admissions = []
    available_filters = {mrn => list_by_mrn(mrn), department => list_by_department(department)}.select{|k,v| !k.blank?}
    counter = 0
    available_filters.each do |k,v|
      admissions = counter == 0 ? v : admissions.merge(v)
      counter += 1
    end
    return admissions
  end

  def latest_appointment_date
    new_app_dates = phone_calls.where(new_appointment: !nil)
    unless new_app_dates.blank?
      return new_app_dates.order('created_at DESC').first
    else
      return appointment_date
    end
  end

  def occupy_bed
    if !bed.blank? and status == Constants::ADMITTED
      bed.update_attribute('status', true)
    end
  end

  def elective
    admission_type == Constants::ELECTIVE
  end

  def emergency
    admission_type != Constants::ELECTIVE
  end

  def set_admission_time
    unless admission_time.blank?
      if admission_date_gr.year != admission_time.year or admission_date_gr.month != admission_time.month or admission_date_gr.day != admission_time.day
        update(admission_time: admission_time.change(year: admission_date_gr.year, month: admission_date_gr.month, day: admission_date_gr.day))
      end
    end
  end

  def set_gregorian_dates
    self[:appointment_date_gr] = Services::EthioGregorianDates.set_gregorian(self.appointment_date, '/')
    self[:admission_date_gr] = Services::EthioGregorianDates.set_gregorian(self.admission_date, '/')
    self[:date_of_registration_gr] = Services::EthioGregorianDates.set_gregorian(self.date_of_registration, '/')
  end

  def self.waiting_total(status)
    total = Admission.where('status = ?', status).count
    return status == Constants::ON_WAITING_LIST ? total - missing_total(status) : total
  end

  def self.missing_total(status)
    Admission.where('date_of_registration_gr < ? and status = ?', Date.today, Constants::ON_WAITING_LIST).count
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
    admissions = []
    if days == 'All Days'
      admissions = where('status = ? and appointment_date_gr >= ?', Constants::ON_WAITING_LIST, Date.today)
    else
      admissions = where('status = ? and appointment_date_gr <= ? and appointment_date_gr >= ?', 
        Constants::ON_WAITING_LIST, Date.today + days.to_i.days, Date.today)
    end
    return admissions
  end

  def self.admitted_list
      where('status = ?', Constants::ADMITTED)
  end

  def self.shortlisted
    where('shortlist = ? and status = ?', true, Constants::ON_WAITING_LIST)
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

  def self.all_elective_admissions(from, to)
    admissions(from, to).where(admission_type: Constants::ELECTIVE)
  end

  def priority_status
    priority == true ? 'Yes' : ''
  end

  def to_s
    patient
  end
end
