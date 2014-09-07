class AddCachedVotesUpAndCachedVotesDownToProblems < ActiveRecord::Migration
  def change
    add_column :problems, :cached_votes_up, :integer, :default => 0
    add_column :problems, :cached_votes_down, :integer, :default => 0

    add_index :problems, :cached_votes_up
    add_index :problems, :cached_votes_down
  end
end
