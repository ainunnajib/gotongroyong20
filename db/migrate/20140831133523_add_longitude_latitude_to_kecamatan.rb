class AddLongitudeLatitudeToKecamatan < ActiveRecord::Migration
  def change
    add_column :kecamatans, :latitude, :float
    add_column :kecamatans, :longitude, :float
  end
end
