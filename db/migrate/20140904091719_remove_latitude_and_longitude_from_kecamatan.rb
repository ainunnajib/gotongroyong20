class RemoveLatitudeAndLongitudeFromKecamatan < ActiveRecord::Migration
  def change
    remove_column :kecamatans, :latitude
    remove_column :kecamatans, :longitude
  end
end
