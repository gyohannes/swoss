json.extract! user, :id, :user_name, :email, :full_name, :role, :created_at, :updated_at
json.url user_url(user, format: :json)
