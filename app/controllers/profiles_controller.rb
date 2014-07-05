class ProfilesController < ApplicationController
  def show
    user = User.find_by_id(params[:id])
    @profile = Profile.new({user: user})
  end
end
