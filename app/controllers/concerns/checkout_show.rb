module CheckoutShow
  extend ActiveSupport::Concern

  included do
    private

    def show_address
      @billing_builder = Billing.find_or_initialize_by(user: current_user)
      @shipping_builder = Shipping.find_or_initialize_by(user: current_user)
      render_wizard
    end

    def show_delivery
      @deliveries = Delivery.all
      render_wizard
    end

    def show_payment
      @credit_card = CreditCard.find_or_initialize_by(user: current_user)
      render_wizard
    end

    def show_confirm
      render_wizard
    end

    def show_complete
      render_wizard
      CheckoutService.call(step, order: current_order, user: current_user)
      session[:order_id] = nil
    end
  end
end
