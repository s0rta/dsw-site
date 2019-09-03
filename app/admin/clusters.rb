ActiveAdmin.register Cluster do
  menu parent: "Sessions", priority: 1

  permit_params :name,
    :description,
    :is_active,
    :header_image,
    :slug

  index do
    selectable_column
    column :name
    column :is_active
    actions
  end

  filter :name

  form do |f|
    f.inputs do
      f.input :name
      f.input :slug
      f.input :description
      f.input :header_image,
        as: :file,
        hint: f.object.header_image.present? ? image_tag(f.object.header_image.url(:thumb)) : nil
      f.input :is_active
    end

    f.actions
  end
end
