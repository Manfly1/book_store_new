# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Order, type: :model do
  let(:order) { create(:order) }

  context 'with associations' do
    it 'has many order_items' do
      expect(order).to respond_to :order_items
    end

    it 'has many books' do
      expect(order).to respond_to :books
    end
  end

  context 'with validations' do
    it 'has default status' do
      expect(order.status).to eq('created')
    end
  end
end
