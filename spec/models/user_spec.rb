require 'rails_helper'

RSpec.describe User, type: :model do
  context 'validation' do
    it 'is invalid without email' do
      expect(build(:user, email: nil)).not_to be_valid
    end

    it 'is valid without name' do
      expect(build(:user, name: nil)).to be_valid
    end
  end

  context 'with associations' do
    it 'has one billing' do
      user = create(:user)
      expect(user).to respond_to :billing
    end

    it 'has one shipping' do
      user = create(:user)
      expect(user).to respond_to :shipping
    end
  end
end
