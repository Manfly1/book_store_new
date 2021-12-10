# frozen_string_literal: true

class ValidateStatusFilter
  include Interactor

  def call
    @status = context.status
    context.valid_status = valid_status
    context.status = show_status
  end

  private

  def valid_status
    Constants::STATUSES_TO_SHOW.include?(@status) ? @status : Constants::DEFAULT_ORDERS_STATUS_FILTER
  end

  def show_status
    case context.valid_status
    when 'all' then I18n.t('order.statuses.all')
    when 'in_delivery' then I18n.t('order.statuses.in_delivery')
    when 'delivered' then I18n.t('order.statuses.delivered')
    when 'canceled' then I18n.t('order.statuses.canceled')
    end
  end
end
