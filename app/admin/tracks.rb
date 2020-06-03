ActiveAdmin.register Track do
  menu parent: "Sessions", priority: 1

  permit_params :color,
    :description,
    :email_alias,
    :has_detail_page,
    :header_image,
    :icon,
    :is_submittable,
    :is_voteable,
    :name,
    :video_required_for_submission,
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
      f.input :header_image,
        as: :file,
        hint: f.object.header_image.present? ? image_tag(f.object.header_image.url(:thumb)) : nil
      f.input :is_submittable, hint: "Make this track an option for CFP submissions"
      f.input :video_required_for_submission, hint: "Require that a video is supplied for CFP submission to this track"
      f.input :is_voteable, hint: "Show submissions in this track during the voting process"
      f.input :has_detail_page
    end

    f.actions
  end
end
