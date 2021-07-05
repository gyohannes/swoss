class AdmissionStatus < ApplicationRecord
  belongs_to :admission

  #before_save :set_gregorian_dates
  after_save :free_bed_if_discharged

  validates :status, presence: true

  #def set_gregorian_dates
   #   self[:status_date] = self.status_date.blank? ? Date.today : Services::EthioGregorianDates.set_gregorian(self.status_date, '/')
  #end

  def free_bed_if_discharged
    if status == Constants::DISCHARGED and admission.bed
      admission.bed.update_attribute('status', nil)
    end
  end

end
