json.array!(@events) do |event|
  json.extract! event, :id, :status, :message, :alert, :metadata, :application_id
  json.url event_url(event, format: :json)
end
