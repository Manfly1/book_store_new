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
      .yield_self(&method(:sort))
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

  def sort(relation)
    sort_param = I18n.t(:sorting).keys.include?(@params[:sort_param]&.to_sym) ? @params[:sort_param] : Constants::DEFAULT_BOOKS_ORDER
    return popular_first(relation) if sort_param == 'popular'

    relation.order(sort_param)
  end

  def popular_first(relation)
    relation.joins(:order_items).group(:id).order('count(order_items.id) desc')
  end
end
