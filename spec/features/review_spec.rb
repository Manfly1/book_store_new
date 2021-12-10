require 'rails_helper'

RSpec.describe 'Book page', type: :feature, js: true do
  let!(:book) { create(:book) }

  context 'when user signed in' do
    it 'user can post review' do
      login_as(create(:user), scope: :user)
      visit(book_path(book))

      fill_in 'review[body]', with: FFaker::Lorem.paragraph
      find('#postReview').click
      expect(page).to have_content(I18n.t('review.created'))
    end
  end

  context 'when user is a guest' do
    it 'user cannot post a review' do
      visit(book_path(book))

      expect(page).not_to have_content('#postReview')
    end
  end

  it 'users cannot see rejected reviews' do
    review = create(:review, book: book, status: :rejected)
    visit(book_path(book))

    expect(page).not_to have_content(review.body)
  end

  it 'users cannot see unprocessed reviews' do
    review = create(:review, book: book, status: :unprocessed)
    visit(book_path(book))

    expect(page).not_to have_content(review.body)
  end
end
