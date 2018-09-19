ActiveAdmin.register Ambassador do

  menu parent: 'Site Content', label: 'Sponsorships'

  permit_params :first_name,
                :last_name,
                :title,
                :company,
                :location,
                :avatar

  # Set a default year filter
  scope('Current', default: true, &:for_current_year)
  scope('Previous Years', &:for_previous_years)

  index do
    selectable_column
    column :avatar do |u|
      image_tag u.avatar.url(:thumb)
    end
    column :year
    column :first_name
    column :last_name
    column :company
    column :title
    column :location
    actions
  end

  filter :year

  form do |f|
    f.inputs(multipart: true) do
      f.input :year
      f.input :avatar, as: :file, hint: image_tag(f.object.avatar.url(:thumb))
      f.input :first_name
      f.input :last_name
      f.input :company
      f.input :title
      f.input :location
    end
    f.actions
  end
end
