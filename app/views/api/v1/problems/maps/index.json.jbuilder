json.array!(@problems) do |problem|
  json.extract! problem, :id, :title, :category_id, :summary, :urgency, :latitude, :longitude
  json.url problem_url(problem, format: :json)
end