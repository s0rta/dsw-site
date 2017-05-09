ActiveAdmin.register User do
  include ActiveAdmin::AjaxFilter

  permit_params :email,
                :password,
                :password_confirmation,
                :remember_me,
                :uid,
                :provider,
                :name,
                :description,
                :is_admin

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
