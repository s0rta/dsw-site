ActiveAdmin.register Venue do

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
