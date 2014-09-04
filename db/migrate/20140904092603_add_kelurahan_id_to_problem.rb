class AddKelurahanIdToProblem < ActiveRecord::Migration
  def change
    add_column :problems, :kelurahan_id, :integer
  end
end
