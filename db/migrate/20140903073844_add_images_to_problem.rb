class AddImagesToProblem < ActiveRecord::Migration
  def change
    add_column :problems, :images, :string, array: true
  end
end
