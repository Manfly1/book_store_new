class CheckoutService
  attr_reader :step, :order, :user

  def initialize(step, order:, user:)
    @step = step
    @order = order
    @user = user
  end

  def self.call(*args)
    new(*args).call
  end

  def call
    case step
    when :address then order.update(status: :in_progress, user: user)
    when :complete then complete
    end
  end

  private

  def complete
    order.update(status: :in_delivery, completed_at: Time.zone.now)
    order.coupon.update(active: false) if order.coupon.present?
    OrderConfirmationMailer.with(user: user).order_confirmation.deliver_now
  end
end
