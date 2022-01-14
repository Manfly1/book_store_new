# frozen_string_literal: true

require 'rails_helper'

RSpec.describe AuthorDecorator do
  subject(:decorator) { described_class.new(author) }

  let(:author) { create(:author, first_name: 'Andrii', last_name: 'Ivaniuk') }

  it '#full_name' do
    expect(decorator.full_name).to eq('Andrii Ivaniuk')
  end
end
