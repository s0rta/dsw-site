ActiveAdmin.register User do

  index do
    column :name
    column :email
    column :description
    default_actions
  end

  filter :name
  filter :email

end
