class SurgicalService < ApplicationRecord
  belongs_to :user
  belongs_to :or_schedule
  belongs_to :or_table, optional: true

  before_save :set_gregorian_dates
  before_save :set_canceled_date, if: :canceled
  after_save :set_surgery_times, if: :operated
  validates :adverse_event, presence: true, if: :adverse

  def set_surgery_times
    if date_operated_gr.year != anesthesia_time.year or date_operated_gr.month != anesthesia_time.month or date_operated_gr.day != anesthesia_time.day
      update(anesthesia_time: anesthesia_time.change(year: date_operated_gr.year, month: date_operated_gr.month, day: date_operated_gr.day))
    end
    if date_operated_gr.year != incision_time.year or date_operated_gr.month != incision_time.month or date_operated_gr.day != incision_time.day
      update(incision_time: incision_time.change(year: date_operated_gr.year, month: date_operated_gr.month, day: date_operated_gr.day))
    end
    if date_operated_gr.year != surgery_end_time.year or date_operated_gr.month != surgery_end_time.month or date_operated_gr.day != surgery_end_time.day
      update(surgery_end_time: surgery_end_time.change(year: date_operated_gr.year, month: date_operated_gr.month, day: date_operated_gr.day))
    end
  end

  def operated
    post_schedule_status == Constants::OPERATED
  end
  def canceled
    post_schedule_status == Constants::CANCELLED
  end

  def adverse
    adverse_event_happened == true
  end

  def set_canceled_date
    if post_schedule_status == Constants::CANCELLED
      self[:date_operated_gr] = Date.today
    end
  end

  def set_gregorian_dates
    self[:date_operated_gr] = Services::EthioGregorianDates.set_gregorian(self.date_operated, '/')
  end

  def self.surgeries_total(status)
    joins(:or_schedule=>:admission).where('post_schedule_status = ?',status).count
  end

  def self.surgeries_month_total(status, month)
    eth_month = fromGregorianToEthiopic(month.year, month.month, month.day)
    year_month_day = eth_month.split('-')
    eth_month = year_month_day[1] + '/' + year_month_day[0]
    from = Services::EthioGregorianDates.eth_month_reporting_start(eth_month)
    to = Services::EthioGregorianDates.eth_month_reporting_end(eth_month)

    return where('post_schedule_status = ? and surgical_services.date_operated_gr >= ? and surgical_services.date_operated_gr <= ?', status, from, to).count
  end

  def self.delay_of_elective_surgical_admission(department,from, to)
    (Admission.elective_admissions(department,from, to).map{|x| x.days_between_reg_and_admission || 0}.sum)/Admission.elective_admissions(department,from,to).count unless Admission.elective_admissions(department,from,to).count == 0
  end

  def self.average_delay_of_elective_surgical_admission(from, to)
    (Admission.all_elective_admissions(from, to).map{|x| x.days_between_reg_and_admission || 0}.sum)/Admission.all_elective_admissions(from,to).count unless Admission.all_elective_admissions(from,to).count == 0
  end

  def self.mean_pre_elective_operative_stay(department, from, to)
    (elective_procedures(department, from, to).map{|es| es.days_between_admission_and_surgery || 0}.sum)/elective_procedures(department, from, to).count.to_f unless elective_procedures(department, from, to).count == 0
  end

  def self.overall_mean_pre_elective_operative_stay(from, to)
    (all_elective_procedures(from, to).map{|es| es.days_between_admission_and_surgery || 0}.sum)/all_elective_procedures(from, to).count.to_f unless all_elective_procedures(from, to).count == 0
  end

  def self.elective_surgery_cancellation_rate(department, from, to)
    (elective_procedures_cancelled(department,from, to) / OrSchedule.elective_procedures_scheduled(department,from, to).to_f)*100 unless OrSchedule.elective_procedures_scheduled(department,from, to) == 0
  end

  def self.elective_procedures_cancelled(department, from, to)
    joins(:or_schedule=>:admission).where('department_id = ? and admission_type = ? and post_schedule_status = ? and scheduled_date_gr >= ? and scheduled_date_gr <= ?',
                                          department, Constants::ELECTIVE, Constants::CANCELLED, from, to).count
  end

  def self.surgical_safety_checklist_completion_rate(department, from, to)
    (elective_procedures_safety_checklist_completed(department,from, to) / elective_procedures(department,from, to).count)*100 unless elective_procedures(department,from, to).count == 0
  end

  def self.overall_surgical_safety_checklist_completion_rate(from, to)
    (all_elective_procedures_safety_checklist_completed(from, to) / all_elective_procedures(from, to).count)*100 unless all_elective_procedures(from, to).count == 0
  end



  def self.elective_procedures_safety_checklist_completed(department,from, to)
    elective_procedures(department,from,to).where(surgical_safety_checklist_completed: true).count
  end

  def self.all_elective_procedures_safety_checklist_completed(from, to)
    all_elective_procedures(from,to).where(surgical_safety_checklist_completed: true).count
  end

  def self.elective_procedures(department, from, to)
    joins(:or_schedule=>:admission).where('department_id = ? and post_schedule_status = ? and admissions.admission_type = ? and date_operated_gr >= ? and date_operated_gr <= ?',
                                          department, Constants::OPERATED, Constants::ELECTIVE, from, to)
  end

  def self.all_elective_procedures(from, to)
    joins(:or_schedule=>:admission).where('post_schedule_status = ? and admissions.admission_type = ? and date_operated_gr >= ? and date_operated_gr <= ?',
                                          Constants::OPERATED, Constants::ELECTIVE, from, to)
  end

  def days_between_admission_and_surgery
    (or_schedule.scheduled_date_gr - or_schedule.admission.admission_date_gr).to_i rescue nil
  end

  def self.or_table_efficiency(month)
    OrTable.count == 0 ? 0 : (surgeries_month_total(Constants::OPERATED, month).to_f/(OrTable.count * 30)).round(2)
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

    return SurgicalService.where('post_schedule_status = ? and date_operated_gr >= ? and date_operated_gr <= ?', Constants::OPERATED, from, to)
  end

  def self.cancellation_rate(from, to)
    ((total_elective_cancelled(from, to)/total_elective(from, to).to_f)*100).round(2) unless total_elective(from, to) == 0
  end
  def self.total_elective_cancelled(from, to)
    joins(:or_schedule=>:admission).where('admission_type = ? and post_schedule_status = ? and scheduled_date_gr >= ? and scheduled_date_gr <= ?',
                                          Constants::ELECTIVE, Constants::CANCELLED, from, to).count
  end

  def self.total_elective(from, to)
    joins(:or_schedule=>:admission).where('admissions.admission_type = ? and scheduled_date_gr >= ? and scheduled_date_gr <= ?',
                                          Constants::ELECTIVE, from, to).count
  end

  def self.month_average_procedure_duration(month)
    return surgeries(month).blank? ? 0 : total_surgery_minutes(month)/surgeries(month).count
  end

  def self.total_surgery_minutes(month)
    surgeries(month).map {|s| s.surgery_time_in_minutes}.sum
  end

  def checklist
    surgical_safety_checklist_completed == true ? 'Yes' : ''
  end

  def self.dep_average_first_case_incision_time(dep, from, to)
    if !from.blank? and !to.blank?
      date_range = (from..to)
      times = []
      date_range.each do |d|
        times << dep_first_procudure(dep,d).incision_time unless dep_first_procudure(dep, d).blank?
      end
      total_minutes = times.map{|t| t.hour * 60 + t.strftime("%M").to_i}.sum
      average_minutes = times.blank? ? 0 : total_minutes/times.size unless total_minutes.blank?
      hours, minutes = average_minutes/60, average_minutes%60 unless average_minutes.blank?
      return "#{hours > 10 ? hours : "#{ '0' << hours.to_s}"}:#{minutes > 10 ? minutes : "#{'0' << minutes.to_s}"}" unless average_minutes.blank?
    end
  end


  def self.average_first_case_incision_time(from, to)
    if !from.blank? and !to.blank?
      date_range = (from..to)
      times = []
      date_range.each do |d|
        times << first_procudure(d).incision_time unless first_procudure(d).blank?
      end
      total_minutes = times.map{|t| t.hour * 60 + t.strftime("%M").to_i}.sum
      average_minutes = times.blank? ? 0 : total_minutes/times.size unless total_minutes.blank?
      hours, minutes = average_minutes/60, average_minutes%60 unless average_minutes.blank?
      return "#{hours > 10 ? hours : "#{ '0' << hours.to_s}"}:#{minutes > 10 ? minutes : "#{'0' << minutes.to_s}"}" unless average_minutes.blank?
    end
  end

  def self.first_procudure(day)
    where('post_schedule_status = ? and date(date_operated_gr) = ?', Constants::OPERATED, day).order('incision_time').first
  end

  def self.dep_first_procudure(dep,day)
    joins(:or_schedule=>:admission).where('department_id = ? and post_schedule_status = ? and date(date_operated_gr) = ?',
                                          dep, Constants::OPERATED, day).order('incision_time').first
  end

  def self.delay_of_emergency_surgery(from, to)
    emergency_procedures(from, to).map{|x| x.emergency_surgery_delay}.sum/emergency_procedures(from, to).count unless emergency_procedures(from, to).blank?
  end

  def self.dep_delay_of_emergency_surgery(dep,from, to)
    dep_emergency_procedures(dep, from, to).map{|x| x.emergency_surgery_delay}.sum/dep_emergency_procedures(dep,from,to).count unless dep_emergency_procedures(dep, from, to).blank?
  end

  def emergency_surgery_delay
    ((incision_time - or_schedule.admission.admission_time)/3600).to_f.round(2)
  end

  def self.emergency_procedures(from, to)
    joins(:or_schedule=>:admission).where('admission_type != ? and post_schedule_status = ? and date_operated_gr >= ? and date_operated_gr <= ?',
                                          Constants::ELECTIVE, Constants::OPERATED, from, to)
  end

  def self.dep_emergency_procedures(dep, from, to)
    joins(:or_schedule=>:admission).where('admission_type != ? and department_id = ? and post_schedule_status = ? and date_operated_gr >= ? and date_operated_gr <= ?',
                                          Constants::ELECTIVE, dep, Constants::OPERATED, from, to)
  end

end
