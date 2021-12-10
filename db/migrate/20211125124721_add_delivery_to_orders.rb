# frozen_string_literal: true

class AddDeliveryToOrders < ActiveRecord::Migration[6.1]
  def change
    add_reference :orders, :delivery, foreign_key: true
  end
end
