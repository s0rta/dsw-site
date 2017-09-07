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
                :state,
                :capacity,
                :extra_directions

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

  form do |f|
    f.inputs do
      f.input :name
      f.input :description, hint: 'This will not be displayed publicly'
      f.input :address
      f.input :suite_or_unit
      f.input :city
      f.input :state
      f.input :capacity
      f.input :extra_directions, hint: 'These will be displayed to the public next to the address'
      f.input :contact_name
      f.input :contact_email, hint: 'Multiple addresses are allowed; separate them with commas'
      f.input :contact_phone
    end
    f.actions
  end

end
