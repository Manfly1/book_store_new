require 'rails_helper'

RSpec.describe BookDecorator do
  subject(:decorator) { described_class.new(book) }

  let(:authors) do
    [
      create(:author, first_name: 'Andrii', last_name: 'Ivaniuk'),
      create(:author, first_name: 'Vasyl', last_name: 'Vasiv')
    ]
  end
  let(:categories) do
    [
      create(:category, name: 'Category 1'),
      create(:category, name: 'Category 2')
    ]
  end
  let(:book) { create(:book, authors: authors, categories: categories) }

  it '#authors_names' do
    expect(decorator.authors_names).to eq('Andrii Ivaniuk, Vasyl Vasiv')
  end

  it '#categories_names' do
    expect(decorator.categories_names).to eq('Category 1, Category 2')
  end

  it '#cover' do
    expect(decorator.cover).to eq(book.images[0])
  end
end
