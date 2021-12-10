# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Users::OmniauthCallbacksController, type: :controller do
  describe '#facebook' do
    let(:current_user) { create(:user) }

    before do
      OmniAuth.config.mock_auth[:facebook] = OmniAuth::AuthHash.new(provider: :facebook, uid: '12345', info: { email: 'admin@example.com', name: 'Andrii', image: FFaker::Avatar.image })
      request.env['omniauth.auth'] = OmniAuth.config.mock_auth[:facebook]
      request.env['devise.mapping'] = Devise.mappings[:user]
    end

    describe '#facebook' do
      context 'with a new facebook user' do
        before { get :facebook }

        it 'authenticate user' do
          expect(warden).to be_authenticated(:user)
        end

        it 'set current_user' do
          expect(subject.current_user).not_to be_nil
        end

        it 'redirect to root_path' do
          expect(response).to redirect_to(root_path)
        end
      end
    end
  end
end
