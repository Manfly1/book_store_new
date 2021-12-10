# frozen_string_literal: true

class OrderDecorator < ApplicationDecorator
  delegate_all

  decorates_association :order_items

  def sub_price
    order_items.sum(&:price)
  end

  def discount(price = nil)
    return Constants::ZERO unless coupon

    price ||= sub_price
    price * coupon.discount / Constants::HUNDRED
  end

  def number
    "Order \##{id}"
  end

  def show_status
    case status
    when 'in_delivery' then I18n.t('order.statuses.in_delivery')
    when 'delivered' then I18n.t('order.statuses.delivered')
    when 'canceled' then I18n.t('order.statuses.canceled')
    end
  end

  def delivery_price
    delivery&.price || 0
  end
end
