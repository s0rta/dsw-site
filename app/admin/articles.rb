ActiveAdmin.register Article do
  include ActiveAdmin::AjaxFilter

  menu parent: "Site Content"

  permit_params :title,
    :body,
    :submitter_id,
    :track_ids,
    publishing_attributes: [:id, :_destroy, :effective_at],
    authorships_attributes: [:id, :_destroy, :user_id, :is_displayed]


  controller do
    def scoped_collection
      resource_class.includes(:publishing)
    end
  end

  index do
    selectable_column
    column :title
    column :submitter
    column :header_image do |u|
      image_tag u.header_image.url(:thumb) if u.header_image.present?
    end
    column :created_at
    column :updated_at
    column 'Publishing' do |article|
      article&.publishing&.effective_at
    end
    column 'Authors' do |article|
      article&.authors
    end

    actions
  end

  filter :title

  form do |f|
    f.inputs do
      f.input :title, as: :string
      f.input :body, as: :medium_editor, wrapper_html: { class: 'ArticleBody'}, input_html: {
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
                "subscript",
                "superscript",
                "pre",
                "html",
              ],
            },
          }.to_json,
        },
      }
      f.input :submitter_id,
        as: :ajax_select,
        collection: [],
        data: {url: filter_admin_users_path, search_fields: %i[name email]}
      f.input :company_id,
        as: :ajax_select,
        collection: [],
        data: {url: filter_admin_companies_path, search_fields: %i[name]}
      f.input :submission_id,
        as: :ajax_select,
        collection: [],
        data: {url: filter_admin_submissions_path, search_fields: %i[title description year]}
      f.input :track_ids, as: :check_boxes, collection: Track.all, label: "Related Track(s)"
      f.input :header_image,
        as: :file,
        hint: f.object.header_image.present? ? image_tag(f.object.header_image.try.url(:thumb)) : nil
    end

    f.has_many :publishing, allow_destroy: true do |pub|
      pub.input :effective_at
    end

    f.has_many :authorships, allow_destroy: true do |authorship|
      authorship.input :user_id,
        as: :ajax_select,
        collection: [],
        data: {url: filter_admin_users_path, search_fields: %i[name email]}
      authorship.input :is_displayed
    end

    f.actions
  end
end
