ActiveAdmin.register Venue do

  menu parent: 'Sessions'

  permit_params :contact_email,
                :contact_name,
                :contact_phone,
                :description,
                :name,
                :address,
                :suite_or_unit,
                :city,
                :state

  index do
    selectable_column
    column :name
    column :contact_name
    column :contact_email
    actions
  end

  filter :name
  filter :contact_name
  filter :contact_email

end
