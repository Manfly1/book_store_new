# frozen_string_literal: true

class OrderConfirmationMailer < ApplicationMailer
  def order_confirmation
    @user_name = params[:user].decorate.name
    mail(to: params[:user].email, subject: I18n.t('mail.completed'))
  end
end
