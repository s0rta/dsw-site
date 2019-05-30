ActiveAdmin.register Article do
  menu parent: "Site Content"

  permit_params :title,
    :body,
    :author_id,
    :published_at

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
      f.input :body, as: :medium_editor, input_html: {
        data: {
          options: '{"spellcheck":false,"toolbar":{"buttons":["bold","italic","underline","anchor","orderedlist","unorderedlist","strikethrough","subscript","superscript","pre","h1","h2","h3","h4","h5","h6","html"]}}',
        },
      }
      f.input :author_id,
        as: :ajax_select,
        collection: [],
        data: {url: filter_admin_users_path, search_fields: %i[name email]}
      f.input :published_at
    end

    f.actions
  end
end
