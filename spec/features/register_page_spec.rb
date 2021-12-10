# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Register page', type: :feature, js: true do
  let!(:user) { create(:user) }

  before do
    visit(new_user_registration_path)
  end

  context 'when account exists' do
    it 'shows message and stays on Register page' do
      fill_in 'user[email]', with: user.email
      fill_in 'user[password]', with: user.password
      fill_in 'user[password_confirmation]', with: user.password
      click_button I18n.t('default.register')
      expect(page).to have_content('Email has already been taken')
    end
  end

  context 'when valid data' do
    it 'shows message and redirect to Home page' do
      fill_in 'user[email]', with: 'email@host.com'
      fill_in 'user[password]', with: user.password
      fill_in 'user[password_confirmation]', with: user.password
      click_button I18n.t('default.register')
      expect(page).to have_content(I18n.t('devise.registrations.signed_up_but_unconfirmed'))
      expect(page).to have_current_path(root_path)
    end
  end

  context 'when invalid data' do
    it 'when invalid confirm password shows message' do
      fill_in 'user[email]', with: 'email@host.com'
      fill_in 'user[password]', with: user.password
      fill_in 'user[password_confirmation]', with: user.password + 'extra'
      click_button I18n.t('default.register')
      expect(page).to have_content('Password confirmation doesn\'t match Password')
    end

    it 'when empty password stays on Register page' do
      fill_in 'user[email]', with: 'email@host.com'
      click_button I18n.t('default.register')
      expect(page).to have_current_path(new_user_registration_path)
    end
  end
end
