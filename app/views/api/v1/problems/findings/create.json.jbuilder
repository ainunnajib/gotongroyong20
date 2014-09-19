json.extract! @finding, :comment, :id, :created_at
json.posted_by @finding.user.name
json.up_vote @finding.cached_votes_up
json.down_vote @finding.cached_votes_down
json.is_owner @finding.user == current_user
json.replies []