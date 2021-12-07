require 'rails_helper'

RSpec.describe DefaultBooksQuery do
  let(:result) { described_class.call(params) }
  let(:params) { {} }
  let!(:first_book) { create(:book, title: 'AAA', price: 1) }
  let!(:second_book) { create(:book, title: 'BBB', price: 2) }
  let!(:third_book) { create(:book) }

  context 'with latest books' do
    let(:params) { { latest_books: nil } }

    before do
      stub_const('Constants::LATEST_BOOK_COUNT', 2)
    end

    it 'returns 2 last books' do
      expect(result).to match_array([third_book, second_book])
    end
  end

  context 'with filtering books' do
    let(:params) { { category: third_book.categories.first.id } }

    it 'returns books from chosen category' do
      expect(result).to match_array([third_book])
    end
  end

  context 'with sorting parameter' do
    let(:params) { { sort_param: 'title ASC' } }

    it 'returns books in chosen order' do
      expect(result).to match_array([first_book, second_book, third_book])
    end
  end

  context 'without sorting parameter' do
    it 'returns books in default order (created_at DESC)' do
      expect(result).to match_array([third_book, second_book, first_book])
    end
  end
end
