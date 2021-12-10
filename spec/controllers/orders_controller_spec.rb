# frozen_string_literal: true

require 'rails_helper'

RSpec.describe OrdersController, type: :controller do
  let(:user) { create(:user, :addresses) }

  before { sign_in(user) }

  describe 'POST update' do
    let(:order) { create(:order) }

    context 'with valid coupon code' do
      let(:coupon) { create(:coupon) }

      it 'updates order and shows a notice' do
        post :update, params: { id: order.id, coupon: { code: coupon.code } }
        expect(flash[:notice]).to eq(I18n.t('coupons.attached'))
      end
    end

    context 'with invalid coupon code' do
      it 'updates order and shows a notice' do
        post :update, params: { id: order.id, coupon: { code: 'non-existing code' } }
        expect(flash[:alert]).to eq(I18n.t('coupons.invalid'))
      end
    end
  end

  describe 'GET index' do
    let(:params) { {} }
    let!(:order1) { create(:order, status: 2, user: user) }
    let!(:order2) { create(:order, status: 3, user: user) }
    let!(:order3) { create(:order, status: 4, user: user) }

    before { get :index, params: params }

    context 'without params' do
      it { expect(assigns(:orders)).to match_array([order1, order2, order3]) }
    end

    context 'with status parameter in_delivery' do
      let(:params) { { status: 'in_delivery' } }

      it { expect(assigns(:orders)).to match_array([order1]) }
    end

    context 'with status parameter delivered' do
      let(:params) { { status: 'delivered' } }

      it { expect(assigns(:orders)).to match_array([order2]) }
    end

    context 'with status parameter canceled' do
      let(:params) { { status: 'canceled' } }

      it { expect(assigns(:orders)).to match_array([order3]) }
    end

    context 'with invalid status parameter' do
      let(:params) { { status: 'somephrase' } }

      it { expect(assigns(:orders)).to match_array([order1, order2, order3]) }
    end
  end

  describe 'GET show' do
    let(:order) { create(:order, user: user) }

    before { get :show, params: { id: order } }

    it { expect(assigns(:order)).to eq(order) }
    it { expect(assigns(:order)).to render_template :show }
  end
end
