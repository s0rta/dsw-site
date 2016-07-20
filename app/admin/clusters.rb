ActiveAdmin.register Cluster do

  permit_params :name

  index do
    selectable_column
    column :name
    actions
  end

  filter :name

end
