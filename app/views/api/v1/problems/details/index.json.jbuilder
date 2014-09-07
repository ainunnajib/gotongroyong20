json.current_page @problems.current_page
json.total_pages @problems.total_pages
json.problems(@problems) do |problem|
  json.extract! problem, :id, :title, :category_name, :summary, :cause, :symptom, :effect, :urgency_name, :images
  json.province_name problem.province.name
  json.kabupaten_name problem.kabupaten.name
  json.kecamatan_name problem.kecamatan.name
  json.kelurahan_name problem.kelurahan.name
  json.reported_by_name problem.reported_by.name
  json.up_vote problem.get_upvotes.count
  json.down_vote problem.get_downvotes.count

  json.url problem_url(problem, format: :html)
end
