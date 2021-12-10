# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Delivery, type: :model do
  let(:delivery) { build(:delivery) }

  context 'with associations' do
    it 'has many orders' do
      expect(delivery).to respond_to :orders
    end
  end
end
