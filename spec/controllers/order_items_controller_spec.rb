require 'rails_helper'

RSpec.describe OrderItemsController, type: :controller do
  let(:order) { create(:order) }

  before { allow(controller).to receive(:current_order).and_return(order.decorate) }

  describe 'GET index' do
    it 'renders :index template' do
      get :index, params: { order_id: order.id }
      expect(response).to render_template :index
    end
  end

  describe 'POST create' do
    let(:book) { create(:book) }
    let(:params) { { order_id: order.id, book_id: book.id, quantity: 1 } }

    context 'with new order item' do
      it 'creates an OrderItem object' do
        expect { post(:create, params: params) }.to change(OrderItem, :count).by(1)
      end
    end

    context 'with book repeats' do
      before { create(:order_item, order: order, book: book, quantity: 1) }

      it 'do not create a dublicate' do
        expect { post(:create, params: params) }.not_to change(OrderItem, :count)
      end
    end

    context 'with invalid params' do
      it 'redirects with alert' do
        post(:create, params: { order_id: order.id, book_id: 0 })
        expect(flash[:alert]).to eq(I18n.t('order.wrong'))
      end
    end
  end

  describe 'DESTROY' do
    let!(:order_item) { create(:order_item, order: order) }

    it 'destroys an OrderItem object' do
      expect { delete(:destroy, params: { order_id: order.id, id: order_item.id }) }.to change(OrderItem, :count).by(-1)
    end

    it 'redirects with alert' do
      delete(:destroy, params: { order_id: order.id, id: 0 })
      expect(flash[:alert]).to eq(I18n.t('order.wrong'))
    end
  end
end
