# frozen_string_literal: true

require 'rails_helper'

RSpec.describe BooksQuery do
  let(:result) { described_class.call(params) }
  let(:params) { {} }
  let(:first_book) { create(:book) }
  let(:second_book) { create(:book) }
  let(:third_book) { create(:book) }

  context 'with sorting parameter popular' do
    let(:params) { { sort_param: 'popular' } }

    before do
      create_list(:order_item, 3, book: first_book, order: create(:order))
      create_list(:order_item, 2, book: second_book, order: create(:order))
      create_list(:order_item, 1, book: third_book, order: create(:order))
    end

    it 'returns books in chosen order' do
      expect(result).to eq([first_book, second_book, third_book])
    end
  end
end
