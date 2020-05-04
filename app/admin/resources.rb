ActiveAdmin.register Resource do
  include ActiveAdmin::AjaxFilter

  menu parent: "GiveToo"

  permit_params :name,
    :description,
    :user_id,
    :company_id,
    :industry_type_id,
    :website,
    :image,
    :expiration_date,
    :contact_information,
    support_area_ids: []

  index do
    selectable_column
    column :name
    column :user
    column :company
    column :expiration_date
    column :created_at
    column :updated_at
    column "Active?" do |resource|
      resource.active? ? "Yes" : "No"
    end

    actions
  end

  filter :name

  form do |f|
    f.inputs do
      f.input :name, as: :string
      f.input :description, as: :medium_editor, wrapper_html: {class: "ArticleBody"}, input_html: {
        data: {
          options: {
            "spellcheck": false,
            "toolbar": {
              "buttons": [
                "bold",
                "italic",
                "underline",
                "h2",
                "quote",
                "anchor",
                "orderedlist",
                "unorderedlist",
                "strikethrough",
                "pre",
              ],
            },
          }.to_json,
        },
      }
      f.input :user_id,
        as: :ajax_select,
        collection: [],
        data: {url: filter_admin_users_path, search_fields: %i[name email]}
      f.input :company_id,
        as: :ajax_select,
        collection: [],
        data: {url: filter_admin_companies_path, search_fields: %i[name]}
      f.input :industry_type_id,
        as: :select,
        collection: IndustryType.all
      f.input :support_area_ids, as: :check_boxes, collection: SupportArea.all, label: "Related Area(s) of Support"
      f.input :image,
        as: :file,
        hint: f.object.image.present? ? image_tag(f.object.image.url(:thumb)) : nil
      f.input :website, as: :string
      f.input :expiration_date
      f.input :contact_information, as: :string
    end

    f.actions
  end
end
