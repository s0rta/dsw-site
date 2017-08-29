ActiveAdmin.register Company do
  include ActiveAdmin::AjaxFilter

  menu parent: 'Users', priority: 1

  permit_params :name

  index do
    selectable_column
    column :name
    actions
  end


  filter :name

end
