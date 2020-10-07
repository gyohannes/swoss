class SurgicalService < ApplicationRecord
  belongs_to :user
  belongs_to :or_schedule
  belongs_to :or_table, optional: true

  def self.surgeries_total(status)
    return Department.all.collect{|d| d.surgeries_total(status)}.sum
  end

  def self.surgeries_month_total(status, month)
    eth_month = fromGregorianToEthiopic(month.year, month.month, month.day)
    year_month_day = eth_month.split('-')
    eth_month = year_month_day[1] + '/' + year_month_day[0]
    from = Services::EthioGregorianDates.eth_month_reporting_start(eth_month)
    to = Services::EthioGregorianDates.eth_month_reporting_end(eth_month)

    return joins(:or_schedule).where('post_schedule_status = ? and scheduled_date_gr >= ? and scheduled_date_gr <= ?', status, from, to).count
  end

  def self.delay_of_elective_surgical_admission(department,from, to)
    (Admission.elective_admissions(department,from, to).map{|x| x.days_between_reg_and_admission || 0}.sum)/Admission.elective_admissions(department,from,to).count unless Admission.elective_admissions(department,from,to).count == 0
  end

  def self.mean_pre_elective_operative_stay(department, from, to)
    (elective_procedures(department, from, to).map{|es| es.days_between_admission_and_surgery || 0}.sum)/elective_procedures(department, from, to).count unless elective_procedures(department, from, to).count == 0
  end

  def self.elective_surgery_cancellation_rate(department, from, to)
    (elective_procedures_cancelled(department,from, to) / OrSchedule.elective_procedures_scheduled(department,from, to))*100 unless OrSchedule.elective_procedures_scheduled(department,from, to). == 0
  end

  def self.elective_procedures_cancelled(department, from, to)
    joins(:or_schedule=>:admission).where('department_id = ? and admission_type = ? and post_schedule_status = ? and scheduled_date_gr >= ? and scheduled_date_gr <= ?',
                                          department, Constants::ELECTIVE, Constants::CANCELLED, from, to).count
  end

  def self.surgical_safety_checklist_completion_rate(department, from, to)
    (elective_procedures_safety_checklist_completed(department,from, to) / elective_procedures(department,from, to).count)*100 unless elective_procedures(department,from, to).count == 0
  end

  def self.elective_procedures_safety_checklist_completed(department,from, to)
    elective_procedures(department,from,to).where(surgical_safety_checklist_completed: true).count
  end

  def self.elective_procedures(department, from, to)
    joins(:or_schedule=>:admission).where('department_id = ? and post_schedule_status = ? and admissions.admission_type = ? and scheduled_date_gr >= ? and scheduled_date_gr <= ?',
                                          department, Constants::OPERATED, Constants::ELECTIVE, from, to)
  end

  def days_between_admission_and_surgery
    (or_schedule.scheduled_date_gr - or_schedule.admission.admission_date_gr).to_i rescue nil
  end

  def self.or_table_efficiency(month)
    OrTable.count == 0 ? 0 : surgeries_month_total(Constants::OPERATED, month)/(OrTable.count * 30)
  end

  def surgery_time_in_minutes
    (surgery_end_time - incision_time)/60
  end

  def self.month_surgeon_efficiency(month)
    surgeries(month).count/(Surgeon.count * 30)
  end

  def self.surgeries(month)
    eth_month = fromGregorianToEthiopic(month.year, month.month, month.day)
    year_month_day = eth_month.split('-')
    eth_month = year_month_day[1] + '/' + year_month_day[0]
    from = Services::EthioGregorianDates.eth_month_reporting_start(eth_month)
    to = Services::EthioGregorianDates.eth_month_reporting_end(eth_month)

    return SurgicalService.joins(:or_schedule).where('post_schedule_status = ? and scheduled_date_gr >= ? and scheduled_date_gr <= ?', Constants::OPERATED, from, to)
  end

  def self.month_average_procedure_duration(month)
    surgeries(month).blank? ? 0 : total_surgery_minutes(month)/surgeries(month).count
  end

  def self.total_surgery_minutes(month)
    surgeries(month).map {|s| s.surgery_time_in_minutes}.sum
  end

end
