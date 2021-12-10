# frozen_string_literal: true

class OrdersQuery
  attr_reader :status, :user

  def initialize(**params)
    @status = params[:status]
    @user = params[:user]
  end

  def self.call(**params)
    new(**params).call
  end

  def call
    Order
      .yield_self(&method(:filter))
  end

  private

  def filter(relation)
    relation.where(user: user, status: status_parameter)
  end

  def status_parameter
    status == Constants::DEFAULT_ORDERS_STATUS_FILTER ? Constants::STATUSES_TO_SHOW : status
  end
end
