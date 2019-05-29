ActiveAdmin.register Article do
  menu parent: "Site Content"

  permit_params :title,
    :description,
    :author_id,
    :published_at,
    index do
    selectable_column
    column :title
    column :author
    column :created_at
    column :updated_at
    column :published_at
    actions
  end

  filter :title

  form do |f|
    f.inputs do
      f.input :title
      f.input :description
      f.input :author_id,
        as: :ajax_select,
        collection: [],
        data: {url: filter_admin_users_path, search_fields: %i[name email]}
      f.input :published_at
    end

    f.actions
  end
end
