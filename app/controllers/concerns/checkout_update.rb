module CheckoutUpdate
  extend ActiveSupport::Concern

  included do
    private

    def update_address
      CheckoutService.call(step, order: current_order, user: current_user)
      current_order.update(use_billing: params.dig(:user, :orders, :use_billing))
      if update_user_addresses
        redirect_to checkout_path(undone_step)
      else
        render_wizard current_user
      end
    end

    def update_delivery
      result = AddDelivery.call(current_order: current_order, delivery_id: params.dig(:order, :delivery_id))
      redirect_to checkout_path(undone_step) if result.success?
    end

    def update_payment
      @credit_card = CreditCard.find_or_initialize_by(user: current_user)
      @credit_card.update(card_params)

      if @credit_card.errors.empty?
        redirect_to checkout_path(undone_step)
      else
        render_wizard @credit_card
      end
    end

    def finalize_order
      render_wizard current_order
    end

    def undone_step
      return :delivery if current_order.delivery.nil?

      return :payment if current_user.credit_card.nil?

      :confirm
    end

    def card_params
      params.require(:credit_card).permit(%i[number card_name cvv expiration_date])
    end

    def address_params
      params.require(:user).permit(
        billing_attributes: %i[first_name last_name address city zip country phone],
        shipping_attributes: %i[first_name last_name address city zip country phone]
      )
    end

    def update_user_addresses
      params[:user][:shipping_attributes] = params.dig(:user, :billing_attributes) if current_order.use_billing
      current_user.update(address_params)
    end
  end
end
