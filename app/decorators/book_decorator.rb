# frozen_string_literal: true

class BookDecorator < Draper::Decorator
  decorates_association :authors

  def self.collection_decorator_class
    PaginatingDecorator
  end

  delegate_all

  def authors_names
    authors.map(&:full_name).join(', ')
  end

  def categories_names
    categories.map(&:name).join(', ')
  end

  def cover
    images.first
  end
end
