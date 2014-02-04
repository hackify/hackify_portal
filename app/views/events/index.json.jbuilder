json.array!(@events) do |event|
  json.extract! event, :id, :title, :room_name, :body, :open, :start, :password
  json.url event_url(event, format: :json)
end
