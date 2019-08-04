ActiveAdmin.register Ethnicity do
  menu parent: "Site Content"

  permit_params :name,
    :is_active

  index do
    selectable_column
    column :name
    column :is_active
    actions
  end
end
