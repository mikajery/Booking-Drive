json.array!(@users_drive_ways) do |users_drive_way|
  json.extract! users_drive_way, :id, :price, :name, :description
  json.url users_drive_way_url(users_drive_way, format: :json)
end
