ActiveAdmin.register Coupon do
  permit_params :active, :code, :discount
end
