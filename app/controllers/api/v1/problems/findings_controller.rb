class Api::V1::Problems::FindingsController < Api::V1::BaseApisController
  before_action :authenticate_user_json!, only: [:create]

  def index
    detail_id = params[:detail_id].to_i
    @findings = Finding.includes(:user).where(problem_id: detail_id).order(:created_at).reverse_order

    # TODO: Optimize this
    @findings.each do |finding|
      if user_signed_in?
        if current_user.voted_for? finding
          my_vote_status = if current_user.voted_up_on? finding then :up else :down end
        else
          my_vote_status = :quo
        end
      else
        my_vote_status = :not_available
      end

      finding.class_eval do
        attr_accessor :my_vote_status
      end

      finding.instance_exec(my_vote_status) do |s|
        self.my_vote_status = s
      end
    end
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
