FactoryBot.define do
  factory :billing do
    first_name { FFaker::Name.first_name }
    last_name { FFaker::Name.last_name }
    address { FFaker::Address.street_address }
    city { FFaker::Address.city }
    zip { FFaker::AddressUS.zip_code.to_i }
    country { FFaker::Address.country }
    phone { FFaker::PhoneNumberUA.mobile_phone_number.to_s }
  end
end
