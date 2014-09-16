class Problem < ActiveRecord::Base
  belongs_to :reported_by, class_name: "User"
  belongs_to :province
  belongs_to :kabupaten
  belongs_to :kecamatan
  belongs_to :kelurahan

  validates :title, :summary, :category_id, :province, :kabupaten, :kecamatan, :kelurahan, :urgency, :address, :presence => true
  before_validation :remove_empty_images

  geocoded_by :address_with_province
  after_validation :geocode

  before_save :set_total_point, :set_latitude_longitude_if_geocode_fail

  acts_as_votable

  def self.all_categories
    return [["Kesehatan", 0], ["Pendidikan", 1], ["Hukum", 2]]
  end

  def self.all_urgencies
    return [["Sangat rendah", 0], ["Rendah", 1], ["Menengah", 2], ["Penting", 3], ["Kritikal", 4]]
  end

  def category_name
    Problem.all_categories[self.category_id][0]
  end

  def urgency_name
    Problem.all_urgencies[self.urgency][0]
  end

  def province_name
    return self.province.name
  end

  def kabupaten_name
    return self.kabupaten.name
  end

  def kecamatan_name
    return self.kecamatan.name
  end

  def kelurahan_name
    return self.kelurahan.name
  end

  def address_with_province
    return self.address + ", " + self.province.name
  end

  def remove_empty_images
    if self.images
      new_images = self.images.inject([]) do |res, image|
        if image and image.length > 0
          res.append(image)
        else
          res
        end
      end
      self.images = new_images
    end
  end

  def set_total_point
    sign = if self.cached_votes_up >= self.cached_votes_down then 1 else -1 end
    normalized_vote_point = sign * Math.log2((self.cached_votes_up - self.cached_votes_down).abs + 1).to_i

    base = 1406818754 #31 July 2014
    if self.created_at
      time_point = (self.created_at.to_i - base) / 15000
    else
      time_point = (Time.now.to_i - base) / 15000
    end

    self.total_point = normalized_vote_point + time_point
  end

  def set_latitude_longitude_if_geocode_fail
    unless (self.latitude? and self.longitude?)
      puts self.kelurahan.latitude
      puts self.kelurahan.longitude
      self.latitude = self.kelurahan.latitude
      self.longitude = self.kelurahan.longitude
    end
  end
end
