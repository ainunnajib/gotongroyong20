class Api::V1::Problems::FindingsController < ApplicationController
  def index
    detail_id = params[:detail_id].to_i
    @findings = Finding.where(problem_id: detail_id).order(:created_at).reverse_order
  end

  def create
    @finding = Finding.new(finding_params)
    @finding.user = current_user
    @finding.problem_id = params[:detail_id].to_i

    if @finding.save
      render json: {status: 'created'}
    else
      render status: :unprocessable_entity
    end
  end

  def finding_params
    params.require(:finding).permit(:comment)
  end
end
