# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Admin Review' do
  before do
    admin_user = create(:admin_user)
    login_as(admin_user, scope: :admin_user)
  end

  context 'with scopes' do
    before do
      visit admin_reviews_path
    end

    it 'shows first the unprocessed reviews' do
      expect(page).to have_css('.scope.unprocessed.selected')
    end

    it 'admin able to see only approved reviews' do
      click_link(I18n.t('review.approved'))
      expect(page).to have_css('.scope.approved.selected')
    end

    it 'admin able to see only rejected reviews' do
      click_link(I18n.t('review.rejected'))
      expect(page).to have_css('.scope.rejected.selected')
    end

    it 'admin able to see all reviews' do
      click_link('All')
      expect(page).to have_css('.scope.all.selected')
    end
  end

  context 'with actions' do
    before do
      create(:review)
      visit admin_reviews_path
      click_link(I18n.t('book.review') + " \##{Review.last.id}")
    end

    it 'admin can change status to approved' do
      click_link(I18n.t('admin.approve'))

      expect(page.html).to include('<td>approved</td>')
    end

    it 'admin can change status to rejected' do
      click_link(I18n.t('admin.reject'))

      expect(page.html).to include('<td>rejected</td>')
    end
  end
end
