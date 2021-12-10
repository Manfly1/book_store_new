# frozen_string_literal: true

class CreateOrderItem
  include Interactor

  def call
    book = Book.find_by(id: context.params[:book_id])
    return context.fail! unless book

    if book_in_cart?(book)
      increment_item_quantity(book)
    else
      order_item = OrderItem.create(context.params)
      return context.fail! unless order_item
    end

    UpdateTotalPrice.call(context.current_order, price: book.price, quantity: context.params[:quantity].to_i, action: :plus)
  end

  private

  def book_in_cart?(book)
    context.current_order.books.include?(book)
  end

  def increment_item_quantity(book)
    order_item = OrderItem.find_by(order: context.current_order, book: book)
    order_item.increment!(:quantity, context.params[:quantity].to_i)
  end
end
