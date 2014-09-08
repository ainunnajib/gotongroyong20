json.array! @findings.each do |key, val|
  json.extract! key, :comment, :id, :created_at
  json.posted_by key.user.name
  json.up_vote key.cached_votes_up
  json.down_vote key.cached_votes_down

  # TODO: Optimize this
  if user_signed_in?
    if current_user.voted_for? key
      json.my_vote_status (if current_user.voted_up_on? key then 'up' else 'down' end)
    else
      json.my_vote_status 'quo'
    end
  else
    json.my_vote_status 'not_available'
  end

  if val
    json.replies do
      json.array! val.each do |key, val|
        json.extract! key, :comment, :id, :created_at
        json.posted_by key.user.name
        json.up_vote key.cached_votes_up
        json.down_vote key.cached_votes_down

        # TODO: Optimize this
        if user_signed_in?
          if current_user.voted_for? key
            json.my_vote_status (if current_user.voted_up_on? key then 'up' else 'down' end)
          else
            json.my_vote_status 'quo'
          end
        else
          json.my_vote_status 'not_available'
        end
      end
    end
  else
    json.replies []
  end
end