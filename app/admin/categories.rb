ActiveAdmin.register Category do
  permit_params :name

  index do
    selectable_column

    column :name do |resource|
      link_to resource.name, resource_path(resource)
    end

    actions
  end
end
