json.array!(@findings) do |finding|
  json.extract! finding, :comment, :created_at
  json.posted_by finding.user.name
end