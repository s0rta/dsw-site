ActiveAdmin.register NewsroomItem do

  menu parent: 'Site Content'

  permit_params :title,
                :release_date,
                :attachment,
                :external_link,
                :is_active

  index do
    selectable_column
    column :release_date
    column :title
    column :is_active
    actions
  end

  filter :title
  filter :is_active

  form do |f|
    f.inputs do
      f.input :release_date, as: :date_select
      f.input :title
      f.input :attachment, as: :file
      f.input :external_link
      f.input :is_active
    end

    f.actions
  end
end
