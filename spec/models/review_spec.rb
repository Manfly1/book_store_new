require 'rails_helper'

RSpec.describe Review, type: :model do
  context 'with associations' do
    it 'belongs to user' do
      review = create(:review, user: create(:user))
      expect(review).to respond_to :user
    end

    it 'belongs to book' do
      review = create(:review, book: create(:book))
      expect(review).to respond_to :book
    end
  end

  describe 'validations' do
    it { is_expected.to validate_presence_of(:body) }
    it { is_expected.to validate_presence_of(:rating) }
  end
end
