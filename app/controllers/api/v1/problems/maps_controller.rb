class Api::V1::Problems::MapsController < Api::V1::BaseApisController
  def index
    @problems = Problem.includes(:kelurahan)

    @problems = @problems.where(province_id: params[:province_id].to_i) if params[:province_id]
    @problems = @problems.where(kabupaten_id: params[:kabupaten_id].to_i) if params[:kabupaten_id]
    @problems = @problems.where(kecamatan_id: params[:kecamatan_id].to_i) if params[:kecamatan_id]
    @problems = @problems.where(kelurahan_id: params[:kelurahan_id].to_i) if params[:kelurahan_id]
    @problems = @problems.where(category_id: params[:category_id].to_i) if params[:category_id]

    if params[:latitude] and params[:longitude]
      @problems = @problems.near([params[:latitude], params[:longitude]], 20)
    end
  end
end
