ActiveAdmin.register SponsorSignup do

  index do
    column :contact_name
    column :contact_email
    column :company
    column :created_at
    default_actions
  end

  filter :name
  filter :contact_name
  filter :contact_email

end
