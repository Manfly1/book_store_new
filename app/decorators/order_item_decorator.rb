# frozen_string_literal: true

class OrderItemDecorator < ApplicationDecorator
  delegate_all

  def price
    book.price * quantity
  end
end
