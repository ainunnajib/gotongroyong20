class Problem < ActiveRecord::Base
  belongs_to :reported_by, class_name: "User"
  belongs_to :province
  belongs_to :kabupaten
  belongs_to :kecamatan

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
    return self.kecamatan.latitude
  end

  def longitude
    return self.kecamatan.longitude
  end
end
