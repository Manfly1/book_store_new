# frozen_string_literal: true

require 'rails_helper'

RSpec.describe UserDecorator do
  subject(:decorator) { described_class.new(user) }

  let(:user) { create(:user) }

  it '#name' do
    expect(decorator.name).to eq(user.name)
  end
end
