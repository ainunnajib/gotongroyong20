json.array!(@problems) do |problem|
  json.extract! problem, :id, :title, :category_id, :summary, :cause, :symptom, :effect, :urgency, :province_id, :kabupaten_id, :kelurahan_id, :reported_by
  json.url problem_url(problem, format: :json)
end
