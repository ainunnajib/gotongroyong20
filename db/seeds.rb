# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

Province.delete_all
Kabupaten.delete_all
Kecamatan.delete_all
Kelurahan.delete_all

CONN = ActiveRecord::Base.connection

def populate_provinces
  inserts = []
  File.open("db/provinces.txt", "r").each_line do |line|
    id, name = line.split("|").map{|l| l.strip.gsub("'", "''")}
    inserts.push("(#{id}, '#{name}')")
  end

  slices = inserts.each_slice(100).to_a
  slices.each do |slice|
    sql = "INSERT INTO provinces(id, name) VALUES #{slice.join(',')}"
    CONN.execute(sql)
  end
end

def populate_kabupatens
  inserts = []
  File.open("db/kabupatens.txt", "r").each_line do |line|
    province_id, id, name = line.split("|").map{|l| l.strip.gsub("'", "''")}
    inserts.push("(#{id}, '#{name}', #{province_id})")
  end

  slices = inserts.each_slice(100).to_a
  slices.each do |slice|
    sql = "INSERT INTO kabupatens(id, name, province_id) VALUES #{slice.join(',')}"
    CONN.execute(sql)
  end
end

def populate_kecamatans
  inserts = []
  File.open("db/kecamatans.txt", "r").each_line do |line|
    kabupaten_id, id, name = line.split("|").map{|l| l.strip.gsub("'", "''")}
    inserts.push("(#{id}, '#{name}', #{kabupaten_id})")
  end

  slices = inserts.each_slice(100).to_a
  slices.each do |slice|
    sql = "INSERT INTO kecamatans(id, name, kabupaten_id) VALUES #{slice.join(',')}"
    CONN.execute(sql)
  end
end

def populate_kelurahans
  inserts = []
  File.open("db/kelurahans.txt", "r").each_line do |line|
    kecamatan_id, id, name = line.split("|").map{|l| l.strip.gsub("'", "''")}
    inserts.push("(#{id}, '#{name}', #{kecamatan_id})")
  end

  slices = inserts.each_slice(100).to_a
  slices.each do |slice|
    sql = "INSERT INTO kelurahans(id, name, kecamatan_id) VALUES #{slice.join(',')}"
    CONN.execute(sql)
  end
end

puts "Populating provinces..."
populate_provinces

puts "Populating kabupatens..."
populate_kabupatens

puts "Populating kecamatans..."
populate_kecamatans

puts "Populating kelurahans..."
populate_kelurahans