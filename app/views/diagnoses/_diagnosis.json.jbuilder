json.extract! diagnosis, :id, :name, :description, :created_at, :updated_at
json.url diagnosis_url(diagnosis, format: :json)
