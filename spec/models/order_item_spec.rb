require 'rails_helper'

RSpec.describe OrderItem, type: :model do
  let(:order_item) { create(:order_item) }

  context 'with associations' do
    it 'belongs to order' do
      expect(order_item).to respond_to :order
    end

    it 'belongs to book' do
      expect(order_item).to respond_to :book
    end
  end

  context 'with validations' do
    it 'has default quantity' do
      expect(order_item.quantity).not_to be nil
    end
  end
end
