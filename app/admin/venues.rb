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
                :seated_capacity,
                :standing_capacity,
                :av_capabilities,
                :extra_directions,
                :venue_host_id

  index do
    selectable_column
    column :name
    column :contact_name
    column :contact_email
    column :seated_capacity
    column :standing_capacity
    # column :venue_host_id
    # column :host, sortable: 'users.name'
    actions
  end

  filter :name
  filter :contact_name
  filter :contact_email
  filter :seated_capacity
  filter :standing_capacity

  form do |f|
    f.inputs do
      f.input :name
      f.input :description, hint: 'This will not be displayed publicly'
      f.input :address
      f.input :suite_or_unit
      f.input :city
      f.input :state
      f.input :seated_capacity
      f.input :standing_capacity
      f.input :av_capabilities
      f.input :extra_directions, hint: 'These will be displayed to the public next to the address'
      f.input :contact_name
      f.input :contact_email, hint: 'Multiple addresses are allowed; separate them with commas'
      f.input :contact_phone
      f.input :venue_host_id, as: :ajax_select, data: { url: filter_admin_users_path, search_fields: %i[name email] }
    end
    f.actions
  end

end
