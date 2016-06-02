ActiveAdmin.register User do

  index do
    selectable_column
    column :name
    column :email
    column :description
    column :is_admin
    actions
  end

  filter :name
  filter :email

end
