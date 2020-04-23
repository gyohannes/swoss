json.extract! phone_call, :id, :admission_id, :patient_response, :information, :action, :new_appointment, :created_at, :updated_at
json.url phone_call_url(phone_call, format: :json)
