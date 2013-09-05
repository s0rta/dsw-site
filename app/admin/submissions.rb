ActiveAdmin.register Submission do

  controller do

    with_role :admin

    def scoped_collection
      resource_class.includes(:track, :submitter, :votes, :comments)
    end

    def show
        @submission = Submission.find(params[:id])
        @versions = @submission.versions
        @submission = @submission.versions[params[:version].to_i].reify if params[:version]
        show!
    end

  end

  index do
    column :title
    column :track, sortable: 'tracks.name'
    column :venue
    column :format
    column :start_day
    column :end_day
    column(:time_range, sortable: 'start_hour') do |s|
      if s.start_hour && s.end_hour
        "#{(Time.now.at_beginning_of_day + s.start_hour.hours).strftime('%l:%M%P')} - #{(Time.now.at_beginning_of_day + s.end_hour.hours).strftime('%l:%M%P')}"
      end
    end
    column :submitter, sortable: 'users.name'
    column('Public', :is_public, sortable: :is_public) { |s| s.is_public? ? 'Yes' : 'No' }
    column('Confirmed', :is_confirmed, sortable: :is_confirmed) { |s| s.is_confirmed? ? 'Yes' : 'No' }
    column :updated_at
    column(:votes, sortable: 'COUNT(votes.id)') { |s| s.votes.size }
    column(:comments, sortable: 'COUNT(comments.id)') { |s| s.comments.size }
    default_actions
  end

  csv do
    column :id
    Submission.content_columns.each do |content_column|
      column(content_column.name.to_sym)
    end
    column :votes do |submission|
      submission.votes.size
    end
    column :comments do |submission|
      submission.comments.size
    end
  end

  filter :title
  filter :description
  filter :track
  filter :theme
  filter :venue
  filter :format
  filter :submitter
  filter :start_day, as: :select, collection: Submission::DAYS
  filter :end_day, as: :select, collection: Submission::DAYS
  filter :time_range, as: :select, collection: Submission::TIME_RANGES
  filter :format, as: :select, collection: Submission::FORMATS
  filter :is_public
  filter :is_confirmed

  form do |f|
    f.inputs do
      f.input :submitter_id, as: :select, collection: User.order(:name).map {|t| [ t.name, t.id ]}, include_blank: false
      f.input :track_id, as: :select, collection: Track.all.map {|t| [ t.name, t.id ]}, include_blank: false
      f.input :theme_id, as: :select, collection: Theme.all.map {|t| [ t.name, t.id ]}, include_blank: true
      f.input :format, as: :select, collection: Submission::FORMATS, include_blank: true
      f.input :time_range, as: :select, label: 'Submitted Time Range', collection: Submission::TIME_RANGES, include_blank: true, input_html: { disabled: true }
      f.input :start_day, as: :select, collection: Submission::DAYS, include_blank: true
      f.input :start_hour, as: :select, collection: collection_for_hour_select, include_blank: false
      f.input :end_day, as: :select, collection: Submission::DAYS, include_blank: true
      f.input :end_hour, as: :select, collection: collection_for_hour_select, include_blank: false
      f.input :venue
      f.input :title
      f.input :description
      f.input :location
      f.input :contact_email
      f.input :estimated_size
      f.input :is_public
      f.input :is_confirmed
      f.input :budget_needed
      f.input :volunteers_needed
      f.input :notes
    end
    f.actions
  end

  sidebar :actions, only: [ :edit, :show ]  do
    link_to 'View on site', submission
  end

  sidebar :versionate, :partial => "admin/version", :only => :show

  show do
    attributes_table *default_attribute_table_rows
    panel 'Recent Updates' do
      table_for submission.versions do
        column 'Modified at' do |v|
          v.created_at.to_s :long
        end
        column 'User' do |v|
          link_to User.find(v.whodunnit).name, admin_user_path(User.find(v.whodunnit))
        end
        column 'View' do |v|
          link_to 'View', { version: v.index}
        end
      end
    end
  end

end
