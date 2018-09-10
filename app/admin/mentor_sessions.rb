ActiveAdmin.register MentorSession do

  menu parent: 'Site Content', label: 'Mentor Sessions'

  permit_params :year,
                :title,
                :timeslot,
                :signup_url

  # Set a default year filter
  scope('Current', default: true, &:for_current_year)
  scope('Previous Years', &:for_previous_years)

  index do
    selectable_column
    column :year
    column :title
    column :timeslot
    actions
  end

  filter :year

end
