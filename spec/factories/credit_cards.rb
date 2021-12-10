FactoryBot.define do
  factory :credit_card do
    card_name { FFaker::Lorem.word }
    number { rand(10).to_s * 16 }
    cvv { rand(10).to_s * 3 }
    expiration_date { (Time.now + rand(1..10).year * rand(0.0..1)).strftime('%m/%y') }
  end
end
