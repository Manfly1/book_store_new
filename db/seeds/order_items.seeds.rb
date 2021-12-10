# frozen_string_literal: true

start_time = 0

after :books, :orders do
  start_time = Time.now

  OrderItem.destroy_all

  Constants::ORDER_ITEMS_COUNT.times do
    OrderItem.create! do |order_item|
      order_item.book = Book.all.sample
      order_item.order = Order.all.sample
      order_item.quantity = rand(1..10)
    end
  end
end

finish_time = Time.now

puts "Order items created in #{finish_time - start_time} seconds"
