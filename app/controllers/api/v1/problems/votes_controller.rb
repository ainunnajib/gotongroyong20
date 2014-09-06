class Api::V1::Problems::VotesController < ApplicationController
  def index
    render_index
  end

  def create
    type = params[:type]
    problem = Problem.find(params[:detail_id])
    if type == "up"
      problem.upvote_from current_user
    elsif type == "down"
      problem.downvote_from current_user
    elsif type == "unvote"
      my_vote_status = if current_user.voted_up_on? problem then :up else :down end
      if my_vote_status == :up then problem.unliked_by current_user else problem.undisliked_by current_user end
    end
    render_index
  end

  private

  def render_index
    problem = Problem.find(params[:detail_id])
    up_vote = problem.get_upvotes.count
    down_vote = problem.get_downvotes.count
    if user_signed_in?
      if current_user.voted_for? problem
        my_vote_status = if current_user.voted_up_on? problem then :up else :down end
      else
        my_vote_status = :quo
      end
    else
      my_vote_status = :not_available
    end
    render json: {my_vote_status: my_vote_status, up_vote: up_vote, down_vote: down_vote}
  end
end
