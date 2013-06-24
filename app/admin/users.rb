ActiveAdmin.register User do

  controller { with_role :admin }

  index do
    column :name
    column :email
    column :description
    column :is_admin
    default_actions
  end

  filter :name
  filter :email

end
