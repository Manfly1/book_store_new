# frozen_string_literal: true

start_time = 0

after :users, :books do
  start_time = Time.now

  Review.destroy_all

  Constants::BOOKS_COUNT.times do |_index|
    Review.create! do |review|
      review.body       = FFaker::Lorem.paragraph
      review.status     = :approved
      review.book       = Book.all.sample
      review.user       = User.all.sample
      review.rating     = rand(1..5)
    end
  end
end

finish_time = Time.now

puts "Reviews created in #{finish_time - start_time} seconds"
