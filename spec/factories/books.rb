# frozen_string_literal: true

FactoryBot.define do
  factory :book do
    title { FFaker::Book.unique.title }
    description { FFaker::Book.description }
    price { rand(5.0..500.00) }
    dimensions { "#{rand(Constants::DIMENSION).round(1)}\"x#{rand(Constants::DIMENSION).round(1)}\"x#{rand(Constants::DIMENSION).round(1)}\"" }
    year { rand(1666..2019) }
    materials { Constants::MATERIALS.sample(rand(1..3)).join(', ') }
    categories { create_list(:category, 1) }
    authors { create_list(:author, 2) }
  end
end
