class PhoneCall < ApplicationRecord
  belongs_to :admission

  validates :patient_response, presence: true

  after_save :update_status

  def remove_patient
    if patient_response == Constants::DIED
      admission.update('status', Constants::REMOVED)
    end
  end

  def update_status
    unless admission.status == Constants::REMOVED
      if self.action == Constants::REMOVE_FROM_WAITLIST or patient_response == Constants::DIED
        as = admission.admission_statuses.build(status: Constants::REMOVED, status_date: Date.today)
        if as.save
          self.admission.update_attribute('status', Constants::REMOVED)
        end
      end
    end

    if self.action == Constants::APPOINTED_WITH_GOOD_REASON
      as = admission.admission_statuses.build(status: Constants::ON_WAITING_LIST, status_date: Date.today)
      if as.save
        self.admission.update_attributes(appointment_date: self.new_appointment, status: Constants::ON_WAITING_LIST)
      end
    end
  end
end
