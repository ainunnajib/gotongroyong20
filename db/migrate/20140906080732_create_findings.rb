class CreateFindings < ActiveRecord::Migration
  def change
    create_table :findings do |t|
      t.integer :problem_id
      t.integer :user_id
      t.text :comment

      t.timestamps
    end
  end
end
