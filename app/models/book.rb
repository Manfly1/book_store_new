# frozen_string_literal: true

class Book < ApplicationRecord
  has_many :authors_books, dependent: :destroy
  has_many :authors, through: :authors_books
  has_many :reviews, dependent: :destroy

  has_many :books_categories, dependent: :destroy
  has_many :categories, through: :books_categories

  has_many :order_items, dependent: :destroy

  has_many_attached :images

  validates :title, :description, :price, :year, presence: true

  validates :price, numericality: { greater_than_or_equal_to: 0, less_than_or_equal_to: 100_000 }
end
