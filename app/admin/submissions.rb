ActiveAdmin.register Submission do

  controller do
    with_role :admin
    def scoped_collection
      resource_class.includes(:track, :theme, :submitter)
    end
  end

  index do
    column :title
    column :track, sortable: 'tracks.name'
    column :theme, sortable: 'themes.name'
    column :format
    column :day
    column :time_range
    column :submitter, sortable: 'users.name'
    column :updated_at
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
      f.input :track_id, as: :select, collection: Track.all.map {|t| [ t.name, t.id ]}, include_blank: false
      f.input :theme_id, as: :select, collection: Theme.all.map {|t| [ t.name, t.id ]}, include_blank: true
      f.input :format, as: :select, collection: Submission::FORMATS, include_blank: true
      f.input :day, as: :select, collection: Submission::DAYS, include_blank: true
      f.input :time_range, as: :select, collection: Submission::TIME_RANGES, include_blank: true
      f.input :title
      f.input :description
      f.input :location
      f.input :contact_email
      f.input :estimated_size
      f.input :notes
    end
    f.actions
  end

end
