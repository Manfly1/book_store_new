# frozen_string_literal: true

start_time = Time.now

Author.destroy_all

Constants::AUTHORS_COUNT.times do
  Author.create! do |author|
    author.first_name = FFaker::Name.unique.first_name
    author.last_name = FFaker::Name.unique.last_name
  end
end

finish_time = Time.now

puts "Authors created in #{finish_time - start_time} seconds"
