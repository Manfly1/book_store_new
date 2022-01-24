# frozen_string_literal: true

class BooksController < ApplicationController
  before_action :save_my_previous_url

  def index
    @book_count = Book.count
    @categories = Category.select(:id, :name)
    @order_param = params[:sort_by] || Constants::DEFAULT_BOOKS_ORDER

    result = BooksQuery.call(category: params[:category], sort_param: params[:sort_by]).page(params[:page]).per(Constants::BOOKS_PER_PAGE)
    @books = BookDecorator.decorate_collection(result)
  end

  def show
    @book = Book.find(params[:id]).decorate
    @reviews = ReviewDecorator.decorate_collection(Review.approved.where(book: @book.object))
    @back = session[:my_previous_url]
  end
end
