class Api::V1::Problems::CategoriesController < Api::V1::BaseApisController
  def index
    @categories = Problem.all_categories
  end
end
