class CreateBooks < ActiveRecord::Migration[6.1]
  def change
    create_table :books do |t|
      t.string :title
      t.text :description
      t.decimal :price, precision: 10, scale: 2
      t.string :dimensions
      t.integer :year
      t.string :materials

      t.timestamps
    end
  end
end
