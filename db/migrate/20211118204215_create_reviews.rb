# frozen_string_literal: true

class CreateReviews < ActiveRecord::Migration[6.1]
  def change
    create_table :reviews do |t|
      t.text :body
      t.integer :status, default: 0
      t.references :user, foreign_key: true
      t.references :book, foreign_key: true
      t.integer :rating

      t.timestamps
    end
  end
end
