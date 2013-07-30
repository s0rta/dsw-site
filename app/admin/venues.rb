ActiveAdmin.register Venue do

  index do
    column :name
    column :contact_name
    column :contact_email
    default_actions
  end

  filter :name
  filter :contact_name
  filter :contact_email

end
