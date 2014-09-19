class Api::V1::Problems::FindingsController < Api::V1::BaseApisController
  before_action :authenticate_user_json!, only: [:create]

  def index
    detail_id = params[:detail_id].to_i
    @findings = Finding.includes(:user).where(problem_id: detail_id).hash_tree
  end

  def create
    if params[:finding][:parent_id]
      parent = Finding.find(params[:finding].delete(:parent_id))
      @finding = parent.children.build(finding_params)
    else
      @finding = Finding.new(finding_params)
    end

    @finding.user = current_user
    @finding.problem_id = params[:detail_id].to_i

    if !@finding.save      
      render status: :unprocessable_entity
    end
  end

  def finding_params
    params.require(:finding).permit(:comment)
  end

  def destroy
    finding = Finding.find(params[:id])

    if (finding.user != current_user)
      render status: :unauthorized
    else
      finding.destroy

      render json: {status: 'deleted'}
    end
  end
end
