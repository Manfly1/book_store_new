start_time = 0

after :books do
  start_time = Time.now

  # Book.all.each do |book|
  #   rand(3..4).times do
  #     book.images.attach(
  #       io: open("app/assets/images/#{rand(1..24)}.jpg"),
  #       filename: 'cover.jpg',
  #       content_type: 'image/jpg'
  #     )
  #   end
  # end
end
finish_time = Time.now

puts "Images attached in #{finish_time - start_time} seconds"
