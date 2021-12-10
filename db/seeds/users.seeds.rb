start_time = Time.now

User.destroy_all

Constants::USERS_COUNT.times do
  User.create! do |user|
    user.name = [FFaker::Name.unique.name, nil].sample
    user.email = FFaker::Internet.unique.email
    user.password = FFaker::Internet.password
    user.skip_confirmation!
  end
end

finish_time = Time.now

puts "Users created in #{finish_time - start_time} seconds"
