require 'rails_helper'

RSpec.describe 'Cart page', type: :feature, js: true do
  let(:current_order) { create(:order) }

  before do
    visit(order_order_items_path(order_id: current_order.id))
  end

  context 'with valid coupon' do
    let(:coupon) { create(:coupon) }

    it 'applies coupon' do
      fill_in 'coupon[code]', with: coupon.code
      find('#apply-coupon').click
      expect(page).to have_content(I18n.t('coupons.attached'))
    end
  end

  context 'with invalid coupon' do
    it 'shows error message' do
      fill_in 'coupon[code]', with: 'non-existing code'
      find('#apply-coupon').click
      expect(page).to have_content(I18n.t('coupons.invalid'))
    end
  end
end
