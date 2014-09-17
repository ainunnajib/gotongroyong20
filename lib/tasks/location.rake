namespace :location do
  task :fetch_geocode => :environment do
    kelurahans = Kelurahan.where("latitude IS NULL").order("id").limit(2500)
    total_remaining_count = Kelurahan.where("latitude IS NULL").count
    kelurahans.each_with_index {|d, index| puts("#{index}/#{total_remaining_count} #{d.name}"); d.geocode; d.save; sleep(0.15);}
  end
end
