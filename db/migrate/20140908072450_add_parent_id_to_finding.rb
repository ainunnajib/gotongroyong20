class AddParentIdToFinding < ActiveRecord::Migration
  def change
    add_column :findings, :parent_id, :integer
  end
end
