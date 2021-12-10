# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Coupon, type: :model do
  let(:coupon) { create(:coupon) }

  context 'with associations' do
    it 'belongs to order' do
      expect(coupon).to respond_to :order
    end
  end

  context 'with validations' do
    it 'has default active status' do
      expect(coupon.active).to be true
    end

    it 'can not be with invalid discount' do
      expect(build(:coupon, discount: 0)).not_to be_valid
      expect(build(:coupon, discount: 100)).not_to be_valid
      expect(build(:coupon, discount: -10)).not_to be_valid
    end
  end
end
