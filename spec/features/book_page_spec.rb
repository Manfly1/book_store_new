# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Book page', type: :feature, js: true do
  let!(:book) { create(:book, description: 'description' * Constants::DESCRIPTION_LIMIT) }

  before do
    visit(book_path(book))
  end

  context 'with description' do
    it 'shows full description' do
      click_link(I18n.t('book.more'))
      expect(page).to have_content(book.description)
    end
  end

  context 'with add_to_cart button' do
    it 'adds book to cart' do
      find('.add-to-cart', match: :first).click
      find('#cart').click
      expect(page).to have_content(book.title)
    end
  end
end
