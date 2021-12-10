class UpdateTotalPrice
  attr_reader :order, :price, :quantity, :action, :delivery, :coupon

  def initialize(order, price: nil, quantity: 1, action: nil, delivery: nil, coupon: nil)
    @order = order
    @price = price
    @quantity = quantity
    @action = action
    @delivery = delivery
    @coupon = coupon
  end

  def self.call(*args)
    new(*args).call
  end

  def call
    return order.increment!(:total_price, difference) if action == :plus

    order.decrement!(:total_price, difference) if action == :minus
  end

  def difference
    return delivery.price if delivery

    return order.discount if coupon

    price * quantity - order.discount(price * quantity)
  end
end
