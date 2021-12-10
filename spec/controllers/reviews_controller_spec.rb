require 'rails_helper'

RSpec.describe ReviewsController, type: :controller do
  describe 'POST create' do
    let(:book) { create(:book) }
    let(:user) { create(:user) }

    it 'creates review and shows a notice' do
      sign_in(user)
      post :create, params: { book_id: book.id, review: {
        body: FFaker::Lorem.paragraph,
        rating: rand(1..5),
        user_id: user.id,
        book_id: book.id
      } }

      expect(response).to redirect_to(book_path(book))
      expect(flash[:notice]).to eq(I18n.t('review.created'))
    end

    it 'shows alert with review errors' do
      sign_in(user)
      post :create, params: { book_id: book.id, review: {
        body: nil,
        rating: rand(1..5),
        user_id: user.id,
        book_id: book.id
      } }

      expect(flash[:alert]).to eq('Body can\'t be blank')
    end
  end
end
