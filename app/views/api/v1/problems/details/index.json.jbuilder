json.array!(@problems) do |problem|
  json.extract! problem, :id, :title, :category_name, :summary, :cause, :symptom, :effect, :urgency_name, :images
  json.province_name problem.province.name
  json.kabupaten_name problem.kabupaten.name
  json.kecamatan_name problem.kecamatan.name
  json.reported_by_name problem.reported_by.name
  json.url problem_url(problem, format: :html)
end
