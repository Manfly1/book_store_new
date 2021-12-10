module Application
  extend ActiveSupport::Concern

  included do
    helper_method :current_order
  end

  def current_user
    super&.decorate
  end

  def current_order
    order = Order.find_or_create_by(id: session[:order_id])
    session[:order_id] = order.id

    order.decorate
  end
end
