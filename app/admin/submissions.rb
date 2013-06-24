ActiveAdmin.register Submission do

  index do
    column :title
    column :track
    column :theme
    column :format
    column :day
    column :time_range
    column :submitter
    default_actions
  end

  filter :title
  filter :description
  filter :track
  filter :theme
  filter :submitter
  filter :day, as: :select, collection: Submission::DAYS
  filter :time_range, as: :select, collection: Submission::TIME_RANGES
  filter :format, as: :select, collection: Submission::FORMATS

  form do |f|
    f.inputs do
      f.input :submitter
      f.input :track
      f.input :theme_id, as: :select, collection: Theme.all.map {|t| [ t.name, t.id ]}
      f.input :format, as: :select, collection: Submission::FORMATS
      f.input :day, as: :select, collection: Submission::DAYS
      f.input :time_range, as: :select, collection: Submission::TIME_RANGES
      f.input :title
      f.input :description
      f.input :location
      f.input :contact_email
      f.input :estimated_size
    end
    f.actions
  end

end
