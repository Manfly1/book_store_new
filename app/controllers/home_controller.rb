# frozen_string_literal: true

class HomeController < ApplicationController
  def index
    @latest_books = BookDecorator.decorate_collection(BooksQuery.call(latest_books: nil))
  end
end
