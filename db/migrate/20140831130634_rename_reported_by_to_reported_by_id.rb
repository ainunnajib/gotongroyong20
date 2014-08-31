class RenameReportedByToReportedById < ActiveRecord::Migration
  def change
    rename_column :problems, :reported_by, :reported_by_id
  end
end
