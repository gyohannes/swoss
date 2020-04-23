class PhoneCall < ApplicationRecord
  belongs_to :admission

  validates :patient_response, presence: true

  after_save :update_status

  def update_status
    if admission.status != Constants::REMOVE_FROM_WAITLIST
      if self.action == Constants::REMOVE_FROM_WAITLIST
        as = admission.admission_statuses.build(status: Constants::REMOVED, status_date: Date.today)
        if as.save
          self.admission.update_attribute('status', Constants::REMOVED)
        end
      end
    end

    if self.action == Constants::APPOINTED_WITH_GOOD_REASON
      admission.update_attribute('appointment_date', self.new_appointment)
    end
  end
end
