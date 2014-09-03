class Api::V1::Problems::DetailsController < ApplicationController
  def index
    @problems = Problem.includes([:reported_by, :kecamatan]).paginate(page: params[:page], per_page: 2)
  end
end
