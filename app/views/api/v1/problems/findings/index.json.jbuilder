json.array!(@findings) do |finding|
  json.extract! finding, :comment, :id, :created_at
  json.posted_by finding.user.name
  json.up_vote finding.cached_votes_up
  json.down_vote finding.cached_votes_down
  json.my_vote_status finding.my_vote_status
end