class ReviewsController < ApplicationController
  before_action :authenticate_user!

  def create
    @review = Review.new(review_params)

    return redirect_to book_path(@review.book), notice: I18n.t('review.created') if @review.save

    redirect_to book_path(@review.book), alert: errors
  end

  private

  def review_params
    params.require(:review).permit(:body, :book_id, :user_id, :rating)
  end

  def errors
    @review.errors.full_messages.join(', ')
  end
end
