require 'rails_helper'

RSpec.describe Book, type: :model do
  context 'when validation' do
    it 'is invalid without title' do
      expect(build(:book, title: nil)).not_to be_valid
    end

    it 'is invalid without description' do
      expect(build(:book, description: nil)).not_to be_valid
    end

    it 'is invalid without price' do
      expect(build(:book, price: nil)).not_to be_valid
    end

    it 'is invalid without year' do
      expect(build(:book, year: nil)).not_to be_valid
    end

    it 'is invalid with incorrect price' do
      expect(build(:book, price: -1)).not_to be_valid
      expect(build(:book, price: 100_001)).not_to be_valid
      expect(build(:book, price: 'price')).not_to be_valid
    end

    it 'is valid with correct price' do
      expect(build(:book, price: 23)).to be_valid
    end
  end

  context 'when associations' do
    let(:book) { create :book }

    it 'has many authors' do
      expect(book).to respond_to :authors
    end

    it 'has many images' do
      expect(book).to respond_to :images
    end

    it 'has many categories' do
      expect(book).to respond_to :categories
    end
  end
end
