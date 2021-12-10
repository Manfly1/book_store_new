class OrderItemsController < ApplicationController
  def index
    @order_items = current_order.order_items.order('created_at DESC')
  end

  def create
    result = CreateOrderItem.call(params: order_item_params, current_order: current_order)

    if result.success?
      redirect_to order_order_items_path(current_order), notice: I18n.t('order.added')
    else
      redirect_to order_order_items_path(current_order), alert: I18n.t('order.wrong')
    end
  end

  def destroy
    result = DestroyOrderItem.call(order_item_id: params[:id], current_order: current_order)

    if result.success?
      redirect_to order_order_items_path(current_order), notice: I18n.t('order.deleted')
    else
      redirect_to order_order_items_path(current_order), alert: I18n.t('order.wrong')
    end
  end

  def update
    UpdateOrderItem.call(order: current_order, params: params)
  end

  private

  def order_item_params
    params.permit(%i[book_id quantity order_id])
  end
end
