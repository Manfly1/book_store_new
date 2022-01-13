# frozen_string_literal: true

class DefaultBooksQuery
  def initialize(**params)
    @params = params
  end

  def self.call(**params)
    new(**params).call
  end

  def call
      .yield_self(&method(:latest_books))
      .yield_self(&method(:filter))
  end

  private

  def latest_books(relation)
    return relation unless @params.include?(:latest_books)

    relation.order('created_at DESC').limit(Constants::LATEST_BOOK_COUNT)
  end

  def filter(relation)
    return relation unless @params[:category].present?

    relation.joins(:books_categories).where(books_categories: { category_id: @params[:category] })
  end
end
