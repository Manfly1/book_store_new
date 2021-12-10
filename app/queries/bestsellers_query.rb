class BestsellersQuery
  def self.call
    sql = %[SELECT DISTINCT ON (bc.category_id) b.*, SUM(oi.quantity) as total_quantity
      FROM order_items oi JOIN
          orders o
          ON oi.order_id = o.id JOIN
          books b
          ON oi.book_id = b.id
      INNER JOIN books_categories bc ON bc.book_id = b.id
      WHERE o.status in (2, 3)
      GROUP BY bc.category_id, b.id
      ORDER BY bc.category_id, total_quantity DESC]

    Book.find_by_sql(sql)
  end
end
