class AddTotalPointToProblem < ActiveRecord::Migration
  def change
    add_column :problems, :total_point, :integer, default: 0
  end
end
