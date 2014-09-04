class CreateKelurahans < ActiveRecord::Migration
  def change
    create_table :kelurahans do |t|
      t.string :kecamatan_id
      t.string :name
    end
  end
end
