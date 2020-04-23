json.extract! admission, :id, :user_id, :patient_id, :admission_type, :diagnosis_id, :procedure_id, :priority, :physician_id, :department_id, :listing_status, :appointment_date, :admission_date, :ward_id, :payment_type_id, :created_at, :updated_at
json.url admission_url(admission, format: :json)
