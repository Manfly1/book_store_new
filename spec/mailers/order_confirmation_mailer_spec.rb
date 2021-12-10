require 'rails_helper'

RSpec.describe OrderConfirmationMailer, type: :mailer do
  let!(:order) { create(:order) }

  describe 'complete  ' do
    let(:mail) { described_class.with(user: order.user).order_confirmation }

    it 'renders the headers' do
      expect(mail.subject).to eq(I18n.t('mail.completed'))
      expect(mail.to).to eq([order.user.email])
    end

    it 'renders the body' do
      expect(mail.body.encoded).to match(I18n.t('mail.thanks'))
    end
  end
end
