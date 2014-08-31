class LocationsController < ApplicationController
  def provinces
    @provinces = Province.all
  end

  def kabupatens
    @kabupatens = Kabupaten.where(province_id: params[:province_id])
  end

  def kecamatans
    @kecamatans = Kecamatan.where(kabupaten_id: params[:kabupaten_id])
  end
end
