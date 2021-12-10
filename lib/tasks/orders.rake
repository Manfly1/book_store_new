namespace :orders do
  desc 'Delete orders older than 3 days'
  task delete_3_days_old: :environment do
    Order.where('created_at < ? and status = ?', 3.days.ago, 0).destroy_all
    puts 'Unused carts are destroyed'
  end
end
