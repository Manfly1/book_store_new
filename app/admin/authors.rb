# frozen_string_literal: true

ActiveAdmin.register Author do
  permit_params :first_name, :last_name

  decorate_with AuthorDecorator

  index do
    selectable_column

    column :full_name do |resource|
      link_to resource.full_name, resource_path(resource)
    end

    actions
  end
end
