class AddReviewsToUser < ActiveRecord::Migration[6.1]
  def change
    add_reference :users, :reviews, foreign_key: true
  end
end
