json.array!(@problems) do |problem|
  json.extract! problem, :latitude, :longitude
end