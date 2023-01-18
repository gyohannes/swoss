class Constants

  PROCEDURE_CATEGORIES = [1,2,3]
  REASON_FOR_ADMISSION = [EMERGENCY = 'Emergency', SCHEDULED = 'Scheduled']
  PATIENT_STATUS = [ON_WAITING_LIST = 'On Waiting List', ADMITTED = 'Admitted', REMOVED = 'Removed', DISCHARGED = 'Discharged']

  ADMISSION_TYPES = [EMERGENCY_NEW = 'Emergency - New', EMERGENCY_REOPERATION = 'Emergency - Reoperation', ELECTIVE = 'Elective']

  STATUS = [READY = 'Ready', NOT_READY_CLINICAL_CONDITIONS = 'Not Ready - Clinical Conditions', NOT_READY_PERSONAL_REASONS = 'Not Ready - Personal Reasons',
            NOT_READY_STAGED_PATIENT = 'Not Ready - Staged Patient', NOT_READY_PENDING_CLINICAL_IMPROVEMENT = 'Not Ready - Pending Clinical Improvement', NOT_READY_HOSPITAL_REASONS = 'Not Ready - Hospital Reasons',
            NOT_READY_PHYSICIAN_REASONS = 'Not Ready - Physician Reasons']

  CALL_RESPONSES = [CONFIRMED = 'Confirmed', PATIENT_DECLINED_SURGERY = 'Patient Declined Surgery', PATIENT_TREATED_ELSEWHERE = 'Patient Treated Elsewhere',
                    DIED = 'Died', NOT_RESPONDED_TO_CALL = 'Not Responded to Call', NOT_READY_CLINICAL_CONDITIONS = 'Not Ready - Clinical Conditions', NOT_READY_PERSONAL_REASONS = 'Not Ready - Personal Reasons',
                    NOT_READY_STAGED_PATIENT = 'Not Ready - Staged Patient', NOT_READY_HOSPITAL_REASONS = 'Not Ready - Hospital Reasons',
                    NOT_READY_PHYSICIAN_REASONS = 'Not Ready - Physician Reasons', AGREED_TO_BE_TRANSFERED = 'Agreed to be Transfered']

  ACTIONS = [REMOVE_FROM_WAITLIST = 'Remove From Waitlist', REFERRED_TO_OTHER_HOSPITAL = 'Referred to Other Hospital', APPOINTED_WITH_GOOD_REASON = 'Appointed With Good Reason']

  PROCEDURE_TYPES = [EMERGENCY = 'Emergency', ELECTIVE = 'Elective', REOPERATION_UNPLANNED = 'Reoperation - unplanned']

  POST_SCHEDULE_STATUS = [OPERATED = 'Operated', CANCELLED = 'Cancelled']

  OPERATION_CANCELLATION_REASONS = [CLINICAL_CONDITION='Clinical condition', ANESTHESIA='Anesthesia', DEATH='Death', SURGICAL_PROCEDURE='Surgical Procedure',
                                    NURSING='Nursing', UNAVAILABLITY_OF_BLOOD='Unavailability of blod and blood products',
                                    UNAVAILABLITY_OF_EQUIPMENT='Unavailability of equipment, drapes',
                                    INTERRUPTION_OF_WATER='Interruption of water and/or electric power', FUMIGATION='Fumigation', OTHER='Other']

  DEATH_REASONS = [CLINICAL_CONDITION='Clinical condition', ANESTHESIA='Anesthesia',
                   SURGICAL_PROCEDURE='Surgical procedure', FALL='Fall', OTHER='Other']

  POSTOPERATIVE_OUTCOME = [ALIVE='Alive', DEAD='Dead']

end