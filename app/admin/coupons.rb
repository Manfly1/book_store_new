# frozen_string_literal: true

ActiveAdmin.register Coupon do
  permit_params :active, :code, :discount
end
