# frozen_string_literal: true

class DestroyOrderItem
  include Interactor

  def call
    order_item = OrderItem.find_by(id: context.order_item_id)
    return context.fail! unless order_item

    UpdateTotalPrice.call(context.current_order, price: order_item.decorate.price, action: :minus)
    order_item.destroy
  end
end
