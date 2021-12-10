start_time = 0

after :users do
  start_time = Time.now

  Order.destroy_all

  Constants::ORDERS_COUNT.times do
    Order.create! do |order|
      order.status = rand(2..4)
      order.user = User.all.sample
    end
  end
end

finish_time = Time.now

puts "Orders created in #{finish_time - start_time} seconds"
