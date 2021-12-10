# frozen_string_literal: true

class Shipping < ApplicationRecord
  belongs_to :user

  validates(
    :first_name,
    :last_name,
    :address,
    :city,
    :zip,
    :country,
    :phone,
    presence: true
  )

  validates_format_of :phone, with: Constants::PHONE_PATTERN, allow_blank: true
  validates :zip, numericality: { only_integer: true }, allow_blank: true
end
