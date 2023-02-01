class Department < ApplicationRecord
  belongs_to :hospital
  has_many :admissions

  validates :name, presence: true

  def waiting_total(status)
    total = admissions.where('status = ?', status).count
    return status == Constants::ON_WAITING_LIST ? total - dep_missing_total : total
  end

  def category_waiting_total(status, category)
    total = admissions.where('status = ? and procedure_category_id = ?', status, category.id).count
    return status == Constants::ON_WAITING_LIST ? total - missing_total(category) : total
  end

  def surgeries_total(status)
    SurgicalService.joins(:or_schedule=>:admission).where('admissions.department_id = ? and post_schedule_status = ?', self.id, status).count
  end

  def surgeon_efficiency(from,to)
    surgeries(from, to).count/(Surgeon.count * 30) rescue nil
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

  def dep_missing_total
    total = 0
    ProcedureCategory.all.each do |pc|
      total += missing_total(pc)
    end
    return total
  end

  def missing_total(category)
    admissions.where("procedure_category_id = ? and date_of_registration_gr < ? and status = ?",
                     category.id, Date.today - category.max_appointment_days, Constants::ON_WAITING_LIST).count
  end

  def to_s
    name
  end

end
