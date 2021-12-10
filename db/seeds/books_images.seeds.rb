start_time = 0

after :books do
  start_time = Time.now

  Book.all.each do |book|
    book.title = Pathname.new(Rails.root.join("app/assets/images/#{Dir.children('app/assets/images/').sample}")).open
  end
end

finish_time = Time.now

puts "Images attached in #{finish_time - start_time} seconds"
