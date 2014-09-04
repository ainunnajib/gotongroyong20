json.array!(@categories) do |category|
  json.id category[1]
  json.name category[0]
end