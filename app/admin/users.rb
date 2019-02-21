ActiveAdmin.register User do
  include ActiveAdmin::AjaxFilter

  permit_params :email,
    :password,
    :password_confirmation,
    :name,
    :description,
    :is_venue_host,
    :is_admin,
    :avatar,
    :team_position,
    :team_priority,
    chaired_track_ids: []

  index do
    selectable_column
    column :avatar do |u|
      image_tag u.avatar.url(:thumb)
    end
    column :name
    column :email
    column :description
    column :is_admin
    column(:registrations) do |u|
      u.registrations.sort.map(&:year).join(", ")
    end
    actions
  end

  form do |f|
    f.inputs do
      f.input :avatar, as: :file, hint: image_tag(f.object.avatar.url(:thumb))
      f.input :name
      f.input :description
      f.input :email
      f.input :team_position
      f.input :team_priority, as: :number, min: 0, max: 10, hint: "Lower values show first"
      f.input :password
      f.input :password_confirmation
      f.input :is_admin
      f.input :chaired_tracks, as: :check_boxes, collection: Track.in_display_order
    end

    f.actions
  end

  filter :name
  filter :email
  filter :is_admin

  controller do
    def scoped_collection
      resource_class.includes(:registrations)
    end

    def update
      if params[:user][:password].blank? && params[:user][:password_confirmation].blank?
        params[:user].delete("password")
        params[:user].delete("password_confirmation")
      end
      super
    end
  end

  show do
    tabs do
      tab :login do
        attributes_table(*(default_attribute_table_rows - %i[encrypted_password reset_password_token provider]))
      end
      tab :registrations do
        table_for user.registrations.order("year asc") do
          column :year
          column do |r|
            link_to "View", admin_user_registration_path(user, r)
          end
        end
      end
    end
  end
end
