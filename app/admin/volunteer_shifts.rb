ActiveAdmin.register VolunteerShift do

  menu parent: 'Volunteers', label: 'Shifts'

  permit_params :name,
                :day,
                :start_hour,
                :end_hour

  index do
    selectable_column
    column :name
    actions
  end

  form do |f|
    f.inputs do
      f.input :name
      f.input :day, as: :select, collection: Submission::DAYS.invert, include_blank: false
      f.input :start_hour, as: :select, collection: collection_for_hour_select
      f.input :end_hour, as: :select, collection: collection_for_hour_select, include_blank: false
    end
    f.actions
  end

end
