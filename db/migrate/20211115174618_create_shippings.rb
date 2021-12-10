# frozen_string_literal: true

class CreateShippings < ActiveRecord::Migration[6.1]
  def change
    create_table :shippings do |t|
      t.belongs_to :user, index: { unique: true }, foreign_key: true
      t.string :first_name
      t.string :last_name
      t.string :address
      t.string :city
      t.integer :zip
      t.string :country
      t.string :phone

      t.timestamps
    end
  end
end
