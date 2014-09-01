class Api::V1::Problems::MapsController < ApplicationController
  def index
    @problems = Problem.includes([:reported_by, :province, :kabupaten, :kecamatan]).all
  end
end
