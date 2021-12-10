class AddReviewsToBook < ActiveRecord::Migration[6.1]
  def change
    add_reference :books, :reviews, foreign_key: true
  end
end
