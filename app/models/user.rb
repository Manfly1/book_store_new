class User < ApplicationRecord
  has_one :billing, dependent: :destroy
  has_one :shipping, dependent: :destroy
  has_many :reviews, dependent: :destroy
  has_many :orders, dependent: :destroy
  has_one :credit_card, dependent: :destroy

  accepts_nested_attributes_for :billing
  accepts_nested_attributes_for :shipping
  accepts_nested_attributes_for :credit_card

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :confirmable, :omniauthable, omniauth_providers: [:facebook]

  def self.from_omniauth(auth)
    where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
      user.email = auth.info.email
      user.password = Devise.friendly_token[0, 20]
      user.name = auth.info.name
      user.provider = auth.provider
      user.uid = auth.uid
      user.skip_confirmation!
    end
  end
end
