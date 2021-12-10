require 'rails_helper'

RSpec.describe UsersController, type: :controller do
  let(:user) { create(:user) }

  before do
    sign_in(user)
  end

  describe 'GET edit' do
    it 'renders edit page' do
      get :edit, params: { id: user.id }
      expect(response).to render_template(:edit)
    end
  end

  describe 'DELETE destroy' do
    it 'destroys user' do
      expect { post :destroy, params: { id: user.id } }.to change(User, :count).by(-1)
      expect(response).to redirect_to(root_path)
    end
  end

  describe 'POST update' do
    before do
      user.billing = build(:billing)
    end

    context 'with valid params' do
      it 'updates user and shows a notice' do
        post :update, params: { id: user.id, user: { billing_attributes: attributes_for(:billing) } }
        expect(response).to redirect_to(edit_user_path)
        expect(flash[:notice]).to eq(I18n.t('settings.account_updated'))
      end
    end

    context 'with invalid params' do
      it 'dont updates user and shows an alert' do
        post :update, params: { id: user.id, user: { billing_attributes: attributes_for(:billing, phone: 'NaN') } }
        expect(response).to render_template(:edit)
      end
    end
  end
end
