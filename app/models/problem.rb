class Problem < ActiveRecord::Base
  belongs_to :reported_by, class_name: "User"

  def self.all_categories
    return [["Kesehatan", 0], ["Pendidikan", 1], ["Hukum", 2]]
  end

  def self.all_urgencies
    return [["Sangat rendah", 0], ["Rendah", 1], ["Menengah", 2], ["Penting", 3], ["Kritikal", 4]]
  end
end
