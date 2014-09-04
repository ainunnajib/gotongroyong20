class Api::V1::Problems::MapsController < ApplicationController
  def index
    @problems = Problem.includes(:kecamatan).all
  end
end
