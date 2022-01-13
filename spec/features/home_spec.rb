# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Home', type: :feature, js: true do
  before do
    create(:category)
    create(:book)

    visit(root_path)
  end

  context 'with carousel' do
    let(:book) { DefaultBooksQuery.call(latest_books: nil).first.title }

    before do
      stub_const('Constants::LATEST_BOOK_COUNT', 1)
    end

    it 'shows the latest books' do
      within('.carousel') do
        expect(page).to have_content(book)
      end
    end

    it 'adds book to cart' do
      click_link(I18n.t('home.buy_now'))
      find('#cart').click
      expect(page).to have_content(book)
    end
  end

  context 'with main' do
    it 'opens books catalog', skip_before: true do
      visit(root_path)
      click_link(I18n.t('home.get_started'))
      expect(page).to have_current_path(books_path)
    end
  end
end
