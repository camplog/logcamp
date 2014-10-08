json.array!(@applications) do |application|
  json.extract! application, :id, :name, :auth_token, :user_id
  json.url application_url(application, format: :json)
end
