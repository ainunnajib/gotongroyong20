class AddLatitudeLongitudeToProblem < ActiveRecord::Migration
  def change
    add_column :problems, :latitude, :float
    add_column :problems, :longitude, :float
  end
end
