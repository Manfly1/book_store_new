require 'rails_helper'

RSpec.describe 'Catalog', type: :feature, js: true do
  before do
    create_list(:category, 4)
  end

  context 'with categories' do
    let(:book) { create(:book, categories: Category.all.sample(1)) }
    let(:extra_book) { create(:book, categories: []) }

    it 'shows books only from choosen category' do
      visit(books_path)
      find('.filter-link', text: book.categories.first.name, match: :first).click
      expect(page).to have_content(book.title)
      expect(page).not_to have_content(extra_book.title)
    end
  end

  context 'with view more', skip_before: true do
    it 'shows more books' do
      create_list(:book, 2)
      stub_const('Constants::BOOKS_PER_PAGE', 1)
      visit(books_path)

      expect { click_link(I18n.t('shop.more')); sleep(1) }.to change { all('.title').count }.by(1)
    end

    it 'hides when all books are shown' do
      create_list(:book, 2)
      stub_const('Constants::BOOKS_PER_PAGE', 1)
      visit(books_path)

      expect(page).to have_content(I18n.t('shop.more'))
      click_link(I18n.t('shop.more'))
      expect(page).not_to have_content(I18n.t('shop.more'))
    end
  end

  context 'with add to cart icon' do
    let!(:book) { create(:book) }

    it 'adds book to cart' do
      visit(books_path)
      find('.add-to-cart', match: :first).click
      find('#cart').click
      expect(page).to have_content(book.title)
    end
  end
end
