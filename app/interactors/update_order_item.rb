class UpdateOrderItem
  include Interactor

  def call
    order_item = OrderItem.find_by(id: context.params[:id], order: context.order)
    return context.fail! unless order_item

    case context.params[:quantity_action]
    when 'plus' then increment_quantity(order_item)
    when 'minus' then decrement_quantity(order_item)
    when 'change' then change_quantity(order_item)
    end
  end

  private

  def increment_quantity(order_item)
    order_item.increment!(:quantity)
    UpdateTotalPrice.call(context.order, price: order_item.book.price, action: :plus)
  end

  def decrement_quantity(order_item)
    return unless order_item.quantity > 1

    order_item.decrement!(:quantity)
    UpdateTotalPrice.call(context.order, price: order_item.book.price, action: :minus)
  end

  def change_quantity(order_item)
    quantity = context.params[:quantity]&.to_i
    return unless quantity

    previous_quantity = order_item.quantity
    order_item.update(quantity: quantity)

    difference = quantity - previous_quantity
    return UpdateTotalPrice.call(context.order, price: order_item.book.price, action: :plus, quantity: difference.abs) if difference.positive?

    UpdateTotalPrice.call(context.order, price: order_item.book.price, action: :minus, quantity: difference.abs)
  end
end
