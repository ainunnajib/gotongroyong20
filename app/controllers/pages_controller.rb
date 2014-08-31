class PagesController < ApplicationController
  def home
    if user_signed_in?
      redirect_to problems_path
    end
  end
end
