# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Author, type: :model do
  context 'when validation' do
    it 'is invalid without first_name' do
      expect(build(:author, first_name: nil)).not_to be_valid
    end

    it 'is invalid without last_name' do
      expect(build(:author, last_name: nil)).not_to be_valid
    end
  end

  context 'when associations' do
    it 'has many books' do
      author = create :author
      expect(author).to respond_to :books
    end
  end
end
