class CreateFindingHierarchy < ActiveRecord::Migration
  def change
    create_table :finding_hierarchies, :id => false do |t|
      t.integer :ancestor_id, :null => false
      t.integer :descendant_id, :null => false
      t.integer :generations, :null => false
    end

    # For "all progeny of…" and leaf selects:
    add_index :finding_hierarchies, [:ancestor_id, :descendant_id, :generations],
              :unique => true, :name => "finding_anc_desc_udx"

    # For "all ancestors of…" selects,
    add_index :finding_hierarchies, [:descendant_id],
              :name => "finding_desc_idx"
  end
end
