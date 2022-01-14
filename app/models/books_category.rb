# frozen_string_literal: true

class BooksCategory < ApplicationRecord
  belongs_to :category
  belongs_to :book
end
