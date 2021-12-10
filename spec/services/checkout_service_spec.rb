# frozen_string_literal: true

require 'rails_helper'

RSpec.describe CheckoutService do
  let(:service) { described_class.call(step, params) }
  let(:params) { { order: order, user: user } }
  let(:step) {}
  let(:order) { create(:order, coupon: create(:coupon)) }
  let(:user) { create(:user) }

  context 'when :address step' do
    let(:step) { :address }

    it 'sets in_progress status to order' do
      expect { service }.to change(order, :status)
      expect(order.status).to eq('in_progress')
    end

    it 'sets user to order' do
      expect { service }.to change(order, :user)
      expect(order.user).to be user
    end
  end

  context 'when :complete step' do
    let(:step) { :complete }

    it 'sets in_delivery status to order' do
      expect { service }.to change(order, :status)
      expect(order.status).to eq('in_delivery')
    end

    it 'sets unactive status to order coupon' do
      expect { service }.to change(order.coupon, :active)
      expect(order.coupon.active).to be false
    end
  end
end
