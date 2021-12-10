# frozen_string_literal: true

start_time = Time.now

Delivery.destroy_all

Constants::DELIVERY_COUNT.times do
  Delivery.create! do |delivery|
    delivery.price = rand(100)
    delivery.days = FFaker::Lorem.word
    delivery.method = FFaker::Lorem.unique.word
  end
end

finish_time = Time.now

puts "Deliveries created in #{finish_time - start_time} seconds"
