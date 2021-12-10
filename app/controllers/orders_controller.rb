class OrdersController < ApplicationController
  before_action :authenticate_user!
  skip_before_action :authenticate_user!, only: :update

  def update
    result = AddCoupon.call(code: params.dig(:coupon, :code), current_order: current_order)

    if result.success?
      flash[:notice] = I18n.t('coupons.attached')
    else
      flash[:alert] = I18n.t('coupons.invalid')
    end

    redirect_to order_order_items_path(order_id: current_order.id)
  end

  def index
    result = ValidateStatusFilter.call(status: params[:status])
    @show_status = result.status

    result = OrdersQuery.call(user: current_user, status: result.valid_status)
    @orders = OrderDecorator.decorate_collection(result)
  end

  def show
    @order = Order.find_by(id: params[:id], user: current_user).decorate
    @billing = current_user.billing.decorate
  end
end
