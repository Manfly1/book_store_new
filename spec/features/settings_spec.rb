require 'rails_helper'

RSpec.describe 'Settings page', type: :feature, js: true do
  let(:password) { 'password' }
  let(:user) { create(:user, password: password) }

  context 'when user unauthorized' do
    it 'wont let user to get access' do
      visit(edit_user_path(user))
      expect(page).to have_current_path(new_user_session_path)
    end
  end

  context 'when user authorized' do
    let(:billing) { [] }
    let(:shipping) { [] }

    before do
      login_as(user, scope: :user)
      visit(edit_user_path(user))
    end

    context 'when billing address' do
      it 'updates users billing data' do
        attributes_for(:billing).each do |key, value|
          next if key == :country

          fill_in "user[billing_attributes][#{key}]", with: value
        end
        find('#save-billing').click
        expect(page).to have_content(I18n.t('settings.account_updated'))
      end
    end

    context 'when shipping address' do
      it 'updates users shipping data' do
        attributes_for(:shipping).each do |key, value|
          next if key == :country

          fill_in "user[shipping_attributes][#{key}]", with: value
        end
        find('#save-shipping').click
        expect(page).to have_content(I18n.t('settings.account_updated'))
      end
    end

    context 'when email change' do
      it 'changes users email' do
        click_link(I18n.t('settings.privacy'))
        fill_in 'email', with: FFaker::Internet.email
        find('#saveEmail').click
        expect(page).to have_content(I18n.t('settings.account_updated'))
      end
    end

    context 'when password change' do
      it 'changes users password' do
        click_link(I18n.t('settings.privacy'))
        fill_in 'current_password', with: password
        fill_in 'password', with: 'newpassword'
        fill_in 'password_confirmation', with: 'newpassword'
        find('#savePassword').click
        expect(page).to have_content(I18n.t('devise.failure.unauthenticated'))
      end
    end
  end
end
