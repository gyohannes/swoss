class Department < ApplicationRecord
  belongs_to :hospital
  has_many :admissions

  validates :name, presence: true

  def waiting_total(status)
    admissions.where('status = ?', status).count
  end

  def category_waiting_total(status, category)
    admissions.where('status = ? and procedure_category_id = ?', status, category).count
  end

  def surgeries_total(status)
    SurgicalService.joins(:or_schedule=>:admission).where('admissions.department_id = ? and post_schedule_status = ?', self.id, status).count
  end

  def surgeon_efficiency(from,to)
    surgeries(from, to).count/(Surgeon.count * 30)
  end

  def total_surgery_minutes(from, to)
    surgeries(from, to).map {|s| s.surgery_time_in_minutes}.sum
  end

  def average_procedure_duration(from, to)
    total_surgery_minutes(from, to)/surgeries(from, to).count unless surgeries(from, to).blank?
  end

  def surgeries(from, to)
    SurgicalService.joins(:or_schedule=>:admission).where('admissions.department_id = ? and post_schedule_status = ? and scheduled_date_gr >= ? and scheduled_date_gr <= ?',
                                                          self.id, Constants::OPERATED, from, to)
  end

  def missing_total(category)
    admissions.where('procedure_category_id = ? and appointment_date_gr < ? and status = ?',
                     category, Date.today, Constants::ON_WAITING_LIST).count
  end

  def to_s
    name
  end

end
