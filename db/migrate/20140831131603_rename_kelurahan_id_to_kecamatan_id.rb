class RenameKelurahanIdToKecamatanId < ActiveRecord::Migration
  def change
    rename_column :problems, :kelurahan_id, :kecamatan_id
  end
end
