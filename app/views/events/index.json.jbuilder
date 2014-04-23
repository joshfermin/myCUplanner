json.array!(@events) do |event|
  json.extract! event, :title, :starts_at, :ends_at
  json.url event_url(event, format: :json)
end