namespace :location do
  task :fetch_geocode => :environment do
    kelurahans = Kelurahan.includes(:kecamatan => {:kabupaten => :province}).where("latitude IS NULL").order("id").limit(2500)
    total_remaining_count = Kelurahan.where("latitude IS NULL").count
    Parallel.each_with_index(kelurahans, in_threads: 4) do |d, index|
      puts("#{index}/#{total_remaining_count} #{d.name}"); d.geocode; d.save;
    end
  end
end
