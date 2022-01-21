start_time = 0

after :books do
  start_time = Time.now

  Book.all.each do |book|
    rand(3..4).times do
      book.images.attach(
        io: URI.open("https://book-store-new-manfly.s3.eu-west-2.amazonaws.com/#{rand(1..24)}.jpg"),
        filename: 'cover.jpg',
        content_type: 'image/jpg',
        identify: false
      )
    end
  end
end
finish_time = Time.now

puts "Images attached in #{finish_time - start_time} seconds"
