json.extract! admission_status, :id, :admission_id, :status_date, :status, :created_at, :updated_at
json.url admission_status_url(admission_status, format: :json)
