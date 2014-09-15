class Problem < ActiveRecord::Base
  belongs_to :reported_by, class_name: "User"
  belongs_to :province
  belongs_to :kabupaten
  belongs_to :kecamatan
  belongs_to :kelurahan

  validates :title, :summary, :category_id, :province, :kabupaten, :kecamatan, :kelurahan, :urgency, :presence => true
  before_save :remove_empty_images

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

  def latitude
    return self.kelurahan.latitude
  end

  def longitude
    return self.kelurahan.longitude
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
end
