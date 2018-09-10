ActiveAdmin.register PitchContest::Entry do

  permit_params :name,
                :video_url,
                :is_active

  index do
    selectable_column
    column :year
    column :name
    column :is_active
    column(:votes) { |e| e.votes.size }
    actions
  end

  filter :name
  filter :year

  # Set a default year filter
  scope('Current', default: true, &:for_current_year)
  scope('Previous Years', &:for_previous_years)

  controller do
    def scoped_collection
      resource_class.includes(:votes)
    end
  end
end
