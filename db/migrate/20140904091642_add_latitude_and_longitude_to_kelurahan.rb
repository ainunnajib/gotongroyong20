class AddLatitudeAndLongitudeToKelurahan < ActiveRecord::Migration
  def change
    add_column :kelurahans, :latitude, :float
    add_column :kelurahans, :longitude, :float
  end
end
