class Api::V1::Problems::DetailsController < ApplicationController
  def index
    @problems = Problem.includes([:reported_by, :kecamatan]).paginate(page: params[:page], per_page: 2)

    @problems = @problems.where(province_id: params[:province_id].to_i) if params[:province_id]
    @problems = @problems.where(kabupaten_id: params[:kabupaten_id].to_i) if params[:kabupaten_id]
    @problems = @problems.where(kecamatan_id: params[:kecamatan_id].to_i) if params[:kecamatan_id]
    @problems = @problems.where(category_id: params[:category_id].to_i) if params[:category_id]
  end
end
