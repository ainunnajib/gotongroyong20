class Api::V1::Problems::DetailsController < Api::V1::BaseApisController
  def index
    @problems = Problem.includes([:reported_by, :province, :kabupaten, :kecamatan, :kelurahan])

    @problems = @problems.where(province_id: params[:province_id].to_i) if params[:province_id]
    @problems = @problems.where(kabupaten_id: params[:kabupaten_id].to_i) if params[:kabupaten_id]
    @problems = @problems.where(kecamatan_id: params[:kecamatan_id].to_i) if params[:kecamatan_id]
    @problems = @problems.where(kelurahan_id: params[:kelurahan_id].to_i) if params[:kelurahan_id]
    @problems = @problems.where(category_id: params[:category_id].to_i) if params[:category_id]

    if params[:order]
      case params[:order]
        when "popular"
          @problems = @problems.order('cached_votes_up - cached_votes_down').reverse_order
        when "latest"
          @problems = @problems.order('created_at').reverse_order
      end
    else
      # hot
      @problems = @problems.order("total_point").reverse_order
    end

    if params[:latitude] and params[:longitude]
      @problems = @problems.near([params[:latitude], params[:longitude]], 20)
    end

    @problems = @problems.paginate(page: params[:page], per_page: 20)
  end

  def show
    @problem = Problem.includes([:reported_by, :province, :kabupaten, :kecamatan, :kelurahan]).find(params[:id])
  end
end
