require 'rails_helper'

RSpec.describe 'Login page', type: :feature, js: true do
  let!(:user) { create(:user) }

  before do
    visit(new_user_session_path)
  end

  context 'with valid data' do
    it 'logining user and redirects to Home page' do
      fill_in 'user[email]', with: user.email
      fill_in 'user[password]', with: user.password
      click_button I18n.t('default.login')

      expect(page).to have_current_path(root_path)
      expect(page).to have_content(I18n.t('devise.sessions.signed_in'))
    end
  end

  context 'with invalid data' do
    it 'shows an error message when invalid email' do
      fill_in 'user[email]', with: user.email + 'extra'
      fill_in 'user[password]', with: user.password
      click_button I18n.t('default.login')

      expect(page).to have_current_path(new_user_session_path)
      expect(page).to have_content(I18n.t('devise.failure.invalid', authentication_keys: 'Email'))
    end

    it 'shows an error message when invalid password' do
      fill_in 'user[email]', with: user.email
      fill_in 'user[password]', with: user.password + 'extra'
      click_button I18n.t('default.login')

      expect(page).to have_current_path(new_user_session_path)
      expect(page).to have_content(I18n.t('devise.failure.invalid', authentication_keys: 'Email'))
    end
  end
end
