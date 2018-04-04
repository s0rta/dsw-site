ActiveAdmin.register Track do

  menu parent: 'Sessions', priority: 1

  permit_params :name,
                :email_alias,
                :icon,
                :color

  index do
    selectable_column
    column :name
    column :email_alias
    column :icon
    column :color
    actions
  end

  filter :name

end
