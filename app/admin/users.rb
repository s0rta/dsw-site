ActiveAdmin.register User do
  include ActiveAdmin::AjaxFilter

  permit_params :email,
                :password,
                :password_confirmation,
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

  form do |f|
    f.inputs do
      f.input :name
      f.input :description
      f.input :email
      f.input :password
      f.input :password_confirmation
      f.input :is_admin
    end

    f.actions
  end

  filter :name
  filter :email

  controller do
    def update
      if params[:user][:password].blank? && params[:user][:password_confirmation].blank?
        params[:user].delete('password')
        params[:user].delete('password_confirmation')
      end
      super
    end
  end

end
