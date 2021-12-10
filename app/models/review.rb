class Review < ApplicationRecord
  belongs_to :user
  belongs_to :book

  enum status: %i[unprocessed approved rejected]

  validates :rating, inclusion: { in: 1..5 }
  validates :body, :rating, presence: true
end
