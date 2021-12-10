require 'rails_helper'

RSpec.describe Billing, type: :model do
  context 'with associations' do
    let(:billing) { build(:billing) }

    it 'belongs to user' do
      expect(billing).to respond_to :user
    end
  end

  context 'with invalid zip' do
    let(:billing) { build(:billing, zip: '49000') }

    it 'is invalid with no integer zip' do
      expect(billing).not_to be_valid
    end
  end

  context 'with invalid phone' do
    let(:billing) { build(:billing, phone: 'phone-number') }

    it 'is invalid with incorrect phone number' do
      expect(billing).not_to be_valid
    end
  end
end
