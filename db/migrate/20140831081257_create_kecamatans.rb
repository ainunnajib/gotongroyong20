class CreateKecamatans < ActiveRecord::Migration
  def change
    create_table :kecamatans do |t|
      t.string :name
      t.integer :kabupaten_id
    end
  end
end
