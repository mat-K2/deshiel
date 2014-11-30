json.array!(@entries) do |entry|
  json.extract! entry, :id, :description
  json.url entry_url(entry, format: :json)
end
