class Kecamatan < ActiveRecord::Base
  belongs_to :kabupaten
  geocoded_by :full_address

  def full_address
    return self.kabupaten.province.name + " " + self.kabupaten.name + " " + self.name
  end
end
