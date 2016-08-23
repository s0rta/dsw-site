ActiveAdmin.register Cluster do

  menu parent: 'Sessions', priority: 1

  permit_params :name, :description

  index do
    selectable_column
    column :name
    actions
  end

  filter :name

end
