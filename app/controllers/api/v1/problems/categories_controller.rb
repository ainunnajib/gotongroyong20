class Api::V1::Problems::CategoriesController < ApplicationController
  def index
    @categories = Problem.all_categories
  end
end
