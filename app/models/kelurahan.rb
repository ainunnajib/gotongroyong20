class Kelurahan < ActiveRecord::Base
  belongs_to :kecamatan
  geocoded_by :full_address

  def full_address
    return self.name + ", " + self.kecamatan.name + ", " + self.kecamatan.kabupaten.name + ", " + self.kecamatan.kabupaten.province.name
  end
end
