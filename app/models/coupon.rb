class Coupon < ApplicationRecord
  belongs_to :order, optional: true

  validates :discount, inclusion: { in: 1..99 }
end
