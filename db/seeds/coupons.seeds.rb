Coupon.destroy_all

start_time = Time.now
Constants::COUPONS_COUNT.times do
  Coupon.create!(code: FFaker::Lorem.unique.word, discount: rand(1..99))
end

finish_time = Time.now

puts "Coupons created in #{finish_time - start_time} seconds"
