# frozen_string_literal: true

module Constants
  BOOKS_PER_PAGE = 8
  DESCRIPTION_LIMIT = 100
  LATEST_BOOK_COUNT = 3
  DEFAULT_BOOKS_ORDER = 'created_at DESC'
  BOOKS_COUNT = 50
  AUTHORS_COUNT = 5
  USERS_COUNT = 5
  MATERIALS = ['Glossy paper', 'Hardcover', 'Soft paper', 'Cardboard'].freeze
  CATEGORIES = ['Mobile development', 'Photo', 'Web design', 'Web development'].freeze
  DIMENSION = (1.0..10.0).freeze
  STARS_COUNT = 5
  PHONE_PATTERN = /\A(\+\d{1,2}\s)?\(?\d{3}\)?[\s.-]\d{3}[\s.-]\d{4}\z/.freeze
  PHONE_MASK = '000 000-0000'
  EMAIL_TO_LOGIN = /[^@]+/.freeze
  COUPONS_COUNT = 50
  DELIVERY_COUNT = 3
  ZERO = 0
  HUNDRED = 100
  ORDERS_COUNT = 50
  ORDER_ITEMS_COUNT = 100
  DEFAULT_ORDERS_STATUS_FILTER = 'all'
  STATUSES_TO_SHOW = %w[in_delivery delivered canceled].freeze
  CARD_DATE_PATTERN = %r{\A([0][1-9])|([1][0-2]/([\d]{2}))\z}.freeze
  CARD_NUMBER_LENGTH = 16
  CARD_CVV_LENGTH = 3
  CARD_DATE_MASK = '00/00'
  CARD_NUMBER_MASK = '0000000000000000'
  CARD_CVV_MASK = '000'
end
