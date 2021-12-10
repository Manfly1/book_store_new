class CreditCard < ApplicationRecord
  belongs_to :user

  validates :number, :card_name, :expiration_date, :cvv, presence: true

  validates_format_of :expiration_date, with: Constants::CARD_DATE_PATTERN
  validates :number, numericality: { only_integer: true }, length: { is: Constants::CARD_NUMBER_LENGTH }
  validates :cvv, numericality: { only_integer: true }, length: { is: Constants::CARD_CVV_LENGTH }
end
