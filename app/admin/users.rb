ActiveAdmin.register User do

  controller { with_role :admin }

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
