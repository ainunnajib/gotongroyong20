class CreateKabupatens < ActiveRecord::Migration
  def change
    create_table :kabupatens do |t|
      t.string :name
      t.integer :province_id
    end
  end
end
