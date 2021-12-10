# frozen_string_literal: true

ActiveAdmin.register Book do
  permit_params :title, :description, :dimensions, :materials,
                :materials, :price, :year, category_ids: [], author_ids: [], images: []

  decorate_with BookDecorator

  index do
    selectable_column

    column :title do |resource|
      link_to resource.title, resource_path(resource)
    end

    column :authors, &:authors_names

    column :categories do |resource|
      resource.categories.each do |category|
        link_to category.name, resource_path(category)
      end
    end

    column :price do |book|
      number_to_currency(book.price)
    end

    actions
  end

  show do
    h1 book.title

    panel :images do
      table do
        book.images.each do |image|
          span image_tag image.variant(resize: '100x100')
        end
      end
    end

    attributes_table do
      row :authors, &:authors_names
      row :categories
      row :year
      row :description
      row :materials
      row :dimensions
      row :price
      row :created_at
      row :updated_at
    end

    active_admin_comments
  end

  form do |f|
    f.inputs do
      f.input :title
      f.input :categories, as: :check_boxes, collection: Category.all
      f.input :authors, as: :check_boxes, collection: AuthorDecorator.decorate_collection(Author.all)
      f.input :description
      f.input :year
      f.input :price
      f.input :materials
      f.input :dimensions
    end

    f.inputs do
      f.input :images, as: :file, input_html: { multiple: true }
    end

    f.object.images.each do |image|
      span image_tag image.variant(resize: '100x100')
      span link_to('X', delete_book_image_admin_book_path(image.id),
                   method: :delete, data: { confirm: 'Delete image?' })
    end

    f.actions
  end

  member_action :delete_book_image, method: :delete do
    ActiveStorage::Attachment.find(params[:id]).purge_later

    redirect_back(fallback_location: edit_admin_book_path)
  end
end
