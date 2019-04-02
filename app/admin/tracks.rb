ActiveAdmin.register Track do
  menu parent: "Sessions", priority: 1

  permit_params :name,
    :description,
    :email_alias,
    :icon,
    :color,
    :is_submittable,
    :is_voteable,
    :video_url

  index do
    selectable_column
    column :name
    column :email_alias
    column :icon
    column :color
    actions
  end

  filter :name

  form do |f|
    f.inputs do
      f.input :name
      f.input :email_alias
      f.input :icon, as: :select, collection: Track::ICONS
      f.input :color, as: :select, collection: Track::COLORS
      f.input :description
      f.input :video_url, hint: "Youtube URL for track video"
      f.input :is_submittable, hint: "Make this track an option for CFP submissions"
      f.input :is_voteable, hint: "Show submissions in this track during the voting process"
    end

    f.actions
  end
end
