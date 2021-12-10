# frozen_string_literal: true

class FastRegistrationsController < ApplicationController
  def new; end

  def create
    user = User.new(
      email: params[:user][:email],
      password: Devise.friendly_token.first(Devise.password_length.first)
    )
    user.skip_confirmation!

    if user.save
      sign_in(:user, user)
      user.send_reset_password_instructions
      redirect_to checkout_path(:address)
    else
      redirect_to new_fast_registration_path, alert: I18n.t('order.wrong')
    end
  end
end
