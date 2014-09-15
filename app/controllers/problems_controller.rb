class ProblemsController < ApplicationController
  before_action :set_problem, only: [:edit, :update, :destroy]
  before_action :authenticate_user!, only: [:new, :edit, :create, :update, :destroy]

  # GET /problems
  # GET /problems.json
  def index
  end

  # GET /problems/1
  # GET /problems/1.json
  def show
    gon.problem_id = params[:id]
    @brainstorm_url = "http://#{params[:id]}.discourse.gotong.royong.org/session/sso?return_path=%2F"
  end

  # GET /problems/new
  def new
    @problem = Problem.new
    @problem.images = []
    initialize_locations(@problem)
    @s3_direct_post = S3_BUCKET.presigned_post(key: "uploads/#{SecureRandom.uuid}/${filename}", success_action_status: 201, acl: :public_read)
  end

  # GET /problems/1/edit
  def edit
    initialize_locations(@problem)
    @s3_direct_post = S3_BUCKET.presigned_post(key: "uploads/#{SecureRandom.uuid}/${filename}", success_action_status: 201, acl: :public_read)
  end

  # POST /problems
  # POST /problems.json
  def create
    @problem = Problem.new(problem_params)
    @problem.reported_by = current_user

    respond_to do |format|
      if @problem.save
        format.html { redirect_to @problem, notice: 'Problem was successfully created.' }
        format.json { render :show, status: :created, location: @problem }
      else
        format.html {
          initialize_locations(@problem)
          @s3_direct_post = S3_BUCKET.presigned_post(key: "uploads/#{SecureRandom.uuid}/${filename}", success_action_status: 201, acl: :public_read)
          render :new
        }
        format.json { render json: @problem.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /problems/1
  # PATCH/PUT /problems/1.json
  def update
    @problem.reported_by = current_user

    respond_to do |format|
      if @problem.update(problem_params)
        format.html { redirect_to @problem, notice: 'Problem was successfully updated.' }
        format.json { render :show, status: :ok, location: @problem }
      else
        format.html {
          initialize_locations(@problem)
          @s3_direct_post = S3_BUCKET.presigned_post(key: "uploads/#{SecureRandom.uuid}/${filename}", success_action_status: 201, acl: :public_read)
          render :edit
        }
        format.json { render json: @problem.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /problems/1
  # DELETE /problems/1.json
  def destroy
    @problem.destroy
    respond_to do |format|
      format.html { redirect_to problems_url, notice: 'Problem was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_problem
      @problem = Problem.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def problem_params
      params.require(:problem).permit(:title, :category_id, :summary, :cause, :symptom, :effect, :urgency,
                                      :province_id, :kabupaten_id, :kecamatan_id, :kelurahan_id, :reported_by, :images => [])
    end

    def initialize_locations(problem)
      gon.province_id = problem.province_id
      gon.kabupaten_id = problem.kabupaten_id
      gon.kecamatan_id = problem.kecamatan_id
      gon.kelurahan_id = problem.kelurahan_id
    end
end
