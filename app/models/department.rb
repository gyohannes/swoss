class Department < ApplicationRecord
  belongs_to :hospital
  has_many :admissions

  def waiting_total(status)
    admissions.where('status = ?', status).count
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
  def missing_total
    admissions.where('appointment_date_gr < ? and status = ?', Date.today, Constants::ON_WAITING_LIST).count
  end

  def to_s
    name
  end

end
