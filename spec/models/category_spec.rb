require 'rails_helper'

RSpec.describe Category, type: :model do
  context 'validation' do
    it 'is invalid without name' do
      expect(build(:category, name: nil)).not_to be_valid
    end
  end

  context 'associations' do
    it 'has many books' do
      category = create :category
      expect(category).to respond_to :books
    end
  end
end
