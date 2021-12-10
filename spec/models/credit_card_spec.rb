# frozen_string_literal: true

require 'rails_helper'

RSpec.describe CreditCard, type: :model do
  let(:card) { build(:credit_card) }

  context 'with associations' do
    it 'belongs to user' do
      expect(card).to respond_to :user
    end
  end

  describe 'validations' do
    it { is_expected.to validate_presence_of(:number) }
    it { is_expected.to validate_presence_of(:card_name) }
    it { is_expected.to validate_presence_of(:expiration_date) }
    it { is_expected.to validate_presence_of(:cvv) }
    it { is_expected.to validate_length_of(:number) }
    it { is_expected.to validate_length_of(:cvv) }
  end
end
