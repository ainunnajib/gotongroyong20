class Api::V1::BaseApisController < ApplicationController
  def authenticate_user_json!
    unless user_signed_in?
      render json: {error: 'User not logged in'}, status: :unprocessable_entity
    end
  end
end
