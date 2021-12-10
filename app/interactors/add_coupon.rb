class AddCoupon
  include Interactor

  def call
    return context.fail! unless coupon_can_be_attached?

    coupon = Coupon.find_by(code: context.code)

    context.current_order.update(coupon: coupon)
    UpdateTotalPrice.call(context.current_order, coupon: coupon, action: :minus)
  end

  private

  def coupon_can_be_attached?
    order_without_coupon? && coupon_valid?
  end

  def coupon_valid?
    Coupon.exists?(code: context.code, active: true)
  end

  def order_without_coupon?
    context.current_order.coupon.nil?
  end
end
