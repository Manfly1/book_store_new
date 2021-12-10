# frozen_string_literal: true

require 'rails_helper'

RSpec.describe ReviewDecorator do
  subject(:decorator) { described_class.new(review) }

  let(:user) { create(:user, name: 'Andrii') }
  let(:review) { create(:review, user: user, created_at: '2021-11-18 00:00:00') }

  it '#to_string' do
    review.id = 1
    expect(decorator.to_string).to eq('Review #1')
  end

  it '#author' do
    expect(decorator.author).to eq('Andrii')
  end

  it '#date' do
    expect(decorator.date).to eq('18.11.2021')
  end
end
