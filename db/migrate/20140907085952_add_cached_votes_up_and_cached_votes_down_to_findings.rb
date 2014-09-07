class AddCachedVotesUpAndCachedVotesDownToFindings < ActiveRecord::Migration
  def change
    add_column :findings, :cached_votes_up, :integer, :default => 0
    add_column :findings, :cached_votes_down, :integer, :default => 0

    add_index :findings, :cached_votes_up
    add_index :findings, :cached_votes_down
  end
end
