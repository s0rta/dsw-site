ActiveAdmin.register Sponsorship do

  menu parent: 'Site Content', label: 'Sponsorships'

  permit_params :year,
                :name,
                :description,
                :logo,
                :level,
                :link_href,
                :track_id,
                :submission_id

  # Set a default year filter
  scope('Current', default: true, &:for_current_year)
  scope('Previous Years', &:for_previous_years)

  index do
    selectable_column
    column :year
    column :name
    column(:level) { |s| s.level.titleize }
    column :track
    column :submission
    actions
  end

  controller do
    def scoped_collection
      resource_class.includes(:track,
                              submission: :track)
    end
  end

  filter :year
  filter :name
  filter :level, as: :select, collection: Sponsorship::LEVELS.map { |l| [ l.titleize, l ] }
  filter :track

  form do |f|
    f.inputs(multipart: true) do
      f.input :name
      f.input :description
      f.input :logo, as: :file, hint: f.object.logo.present? ? image_tag(f.object.logo.url, width: '100') : content_tag(:span, 'No logo yet')
      f.input :link_href, hint: 'Destination when a user clicks on the logo on the sponsors page'
      f.input :level, as: :select, collection: Sponsorship::LEVELS.map { |l| [ l.titleize, l ] }, include_blank: false
      f.input :track_id, as: :select, collection: Track.all
      f.input :submission_id, as: :select, collection: Submission.for_current_year.for_schedule
      f.input :year
    end
    f.actions
  end
end
