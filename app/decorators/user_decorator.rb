# frozen_string_literal: true

class UserDecorator < ApplicationDecorator
  delegate_all

  def name
    object.name || email[Constants::EMAIL_TO_LOGIN].capitalize
  end
end
