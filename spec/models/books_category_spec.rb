# frozen_string_literal: true

require 'rails_helper'

RSpec.describe BooksCategory, type: :model do
  describe '#associations' do
    it { is_expected.to belong_to(:category) }
    it { is_expected.to belong_to(:book) }
  end
end
