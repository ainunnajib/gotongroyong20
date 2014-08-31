module ProblemsHelper
  def long_lat_points(problems)
    res = []
    problems.each do |problem|
      res.append([problem.kecamatan.latitude, problem.kecamatan.longitude])
    end
    return res.to_json
  end
end
