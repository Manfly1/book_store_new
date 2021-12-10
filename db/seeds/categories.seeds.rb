Category.destroy_all

start_time = Time.now

Constants::CATEGORIES.each { |category| Category.create!(name: category) }

finish_time = Time.now

puts "Categories created in #{finish_time - start_time} seconds"
