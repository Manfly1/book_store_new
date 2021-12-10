# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Shipping, type: :model do
  context 'with associations' do
    let(:shipping) { build(:shipping) }

    it 'belongs to user' do
      expect(shipping).to respond_to :user
    end
  end

  context 'with invalid zip' do
    let(:shipping) { build(:shipping, zip: '49000') }

    it 'is invalid with no integer zip' do
      expect(shipping).not_to be_valid
    end
  end

  context 'with invalid phone' do
    let(:shipping) { build(:shipping, phone: 'phone-number') }

    it 'is invalid with incorrect phone number' do
      expect(shipping).not_to be_valid
    end
  end
end
