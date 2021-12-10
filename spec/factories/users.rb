FactoryBot.define do
  factory :user do
    name { FFaker::Name.name }
    email { FFaker::Internet.email }
    password { FFaker::Internet.password }
    confirmed_at { Time.zone.now }

    trait :addresses do
      billing { build(:billing) }
      shipping { build(:shipping) }
    end

    trait :credit_card do
      credit_card { build(:credit_card) }
    end
  end
end
