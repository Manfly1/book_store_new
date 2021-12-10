FactoryBot.define do
  factory :order do
    user { create(:user) }

    trait :delivery do
      delivery { create(:delivery) }
    end

    trait :coupon do
      coupon { create(:coupon) }
    end
  end
end
