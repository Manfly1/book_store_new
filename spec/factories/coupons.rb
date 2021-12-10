# frozen_string_literal: true

FactoryBot.define do
  factory :coupon do
    code { FFaker::Lorem.word }
    active { true }
    discount { rand(1..99) }
  end
end
