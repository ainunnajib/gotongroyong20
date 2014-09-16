class AddAddressToProblem < ActiveRecord::Migration
  def change
    add_column :problems, :address, :text
  end
end
