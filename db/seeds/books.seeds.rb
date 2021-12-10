# frozen_string_literal: true

start_time = 0

after :authors, :categories do
  start_time = Time.now

  Book.destroy_all

  Constants::BOOKS_COUNT.times do
    Book.create! do |book|
      book.title        = FFaker::Book.unique.title
      book.description  = FFaker::Book.description
      book.price        = rand(5.0..500.00)
      book.dimensions   = "#{rand(Constants::DIMENSION).round(1)}\"x#{rand(Constants::DIMENSION).round(1)}\"x#{rand(Constants::DIMENSION).round(1)}\""
      book.year         = rand(1666..2019)
      book.materials    = Constants::MATERIALS.sample(rand(1..3)).join(', ')
      book.categories   = Category.all.sample(1)
      book.authors      = Author.all.sample(rand(1..2))
    end
  end
end

finish_time = Time.now

puts "Books created in #{finish_time - start_time} seconds"
