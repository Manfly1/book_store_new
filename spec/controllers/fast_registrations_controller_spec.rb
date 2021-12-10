# frozen_string_literal: true

require 'rails_helper'

RSpec.describe FastRegistrationsController, type: :controller do
  describe 'POST create' do
    context 'with valid params' do
      it 'creates user and redirects to checkout' do
        post :create, params: { user: { email: FFaker::Internet.email } }
        expect(response).to redirect_to(checkout_path(:address))
      end
    end

    context 'with invalid params' do
      it 'dont updates user and shows an alert' do
        post :create, params: { user: { email: nil } }
        expect(response).to redirect_to(new_fast_registration_path)
        expect(flash[:alert]).to eq(I18n.t('order.wrong'))
      end
    end
  end
end
