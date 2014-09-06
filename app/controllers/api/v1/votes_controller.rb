class Api::V1::VotesController < ApplicationController
  before_action :get_model_name

  def index
    render_index
  end

  def create
    type = params[:type]
    case @model_name
      when "Problem"
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
      else
        render json: {errors: ['Unknown model name']}, status: :unprocessable_entity
    end
  end

  private

  def get_model_name
    @model_name = params[:model_name]
  end

  def render_index
    case @model_name
      when "Problem"
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
      else
        render json: {errors: ['Unknown model name']}, status: :unprocessable_entity
    end
  end
end