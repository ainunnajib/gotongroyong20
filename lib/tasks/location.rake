namespace :location do
  task :fetch_geocode => :environment do
    kelurahans = Kelurahan.where("latitude IS NULL")
    length = kelurahans.count
    kelurahans.each_with_index {|d, index| puts("#{index}/#{length} #{d.name}"); d.geocode; d.save; sleep(0.15);}
  end
end
