ActiveAdmin.register VolunteerShift do

  config.filters = false

  menu parent: 'Volunteers', label: 'Shifts'

  permit_params :name,
                :venue_id,
                :day,
                :start_hour,
                :end_hour

  index do
    selectable_column
    column :name
    actions
  end

  # Set a default year filter
  scope('Current', default: true, &:for_current_year)
  scope('Previous Year', &:for_previous_years)

  form do |f|
    f.inputs do
      f.input :name
      f.input :venue_id, as: :select, collection: Venue.alphabetical.map {|v| [ v.name, v.id ]}, include_blank: true
      f.input :day, as: :select, collection: Submission::DAYS.invert, include_blank: false
      f.input :start_hour, as: :select, collection: collection_for_hour_select
      f.input :end_hour, as: :select, collection: collection_for_hour_select, include_blank: false
    end
    f.actions
  end
end
