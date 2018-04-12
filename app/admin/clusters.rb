ActiveAdmin.register Cluster do

  menu parent: 'Sessions', priority: 1

  permit_params :name, :description, :is_active

  index do
    selectable_column
    column :name
    column :is_active
    actions
  end

  filter :name

end
