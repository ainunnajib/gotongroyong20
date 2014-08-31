class CreateProblems < ActiveRecord::Migration
  def change
    create_table :problems do |t|
      t.string :title
      t.integer :category_id
      t.text :summary
      t.text :cause
      t.text :symptom
      t.text :effect
      t.integer :urgency
      t.integer :province_id
      t.integer :kabupaten_id
      t.integer :kelurahan_id
      t.integer :reported_by

      t.timestamps
    end
  end
end
