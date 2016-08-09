ActiveAdmin.register Volunteership do

  menu parent: 'Volunteers', label: 'Signups'

  permit_params :year,
                :mobile_phone_number,
                :affiliated_organization,
                available_shift_ids: [],
                assigned_shift_ids: []

  controller do
    def scoped_collection
      resource_class.joins(:user).includes(:available_shifts, :assigned_shifts)
    end
  end

  # Set a default year filter
  scope('Current', default: true, &:for_current_year)
  scope('Previous Year', &:for_previous_years)

  index do
    selectable_column
    column(:name, sortable: 'users.name') { |v| v.user.name }
    column :mobile_phone_number
    column :affiliated_organization
    column('Available Shifts', sortable: false) do |v|
      v.available_shifts.map(&:name) * ', '
    end
    column('Assigned Shifts', sortable: false) do |v|
      v.assigned_shifts.map(&:name) * ', '
    end
    actions
  end

  filter :available_shifts, label: 'Available for shift', as: :select, collection: VolunteerShift.all
  filter :assigned_shifts, label: 'Assigned to shift', as: :select, collection: VolunteerShift.all

  form do |f|
    f.inputs do
      f.input :year
      f.input :mobile_phone_number
      f.input :affiliated_organization
      f.input :available_shift_ids, as: :select, collection: volunteer_shifts_for_select, multiple: true
      f.input :assigned_shift_ids, as: :select, collection: volunteer_shifts_for_select, multiple: true
    end
    f.actions
  end

  batch_action :assign_to_shift, form: -> { { shift: VolunteerShift.for_select } } do |ids, inputs|
    Volunteership.where(id: ids).map { |v| v.update!(assigned_shift_ids: v.assigned_shift_ids + [ inputs[:shift].to_i ]) }
    redirect_to collection_path
  end

  batch_action :remove_from_shift, form: -> { { shift: VolunteerShift.for_select } } do |ids, inputs|
    Volunteership.where(id: ids).map { |v| v.update!(assigned_shift_ids: v.assigned_shift_ids - [ inputs[:shift].to_i ]) }
    redirect_to collection_path
  end

end
