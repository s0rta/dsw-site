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

  # Set a default year filter
  scope 'Current', default: true do |submissions|
    submissions.for_current_year
  end

  scope 'Previous Year' do |submissions|
    submissions.for_previous_years
  end

  index do
    selectable_column
    column :title
    column :track, sortable: 'tracks.name'
    column :venue
    column :start_day
    column :end_day
    column(:time_range, sortable: 'start_hour') do |s|
      "#{(Time.now.at_beginning_of_day + s.start_hour.hours).strftime('%l:%M%P')} - #{(Time.now.at_beginning_of_day + s.end_hour.hours).strftime('%l:%M%P')}" if s.start_hour && s.end_hour
    end
    column :submitter, sortable: 'users.name'
    column('Status', sortable: :state) do |submission|
      status_tag submission.state.to_s.titleize, status_for_submission(submission)
    end
    column(:votes, sortable: 'COUNT(votes.id)') { |s| s.votes.size }
    column(:comments, sortable: 'COUNT(comments.id)') { |s| s.comments.size }
    default_actions
  end

  csv do
    column :id
    column :title
    column :description
    column :notes
    column :track do |submission|
      submission.track.try(:name)
    end
    column :format
    column :venue do |submission|
      submission.venue.try(:name)
    end
    column :start_day
    column :end_day
    column :submitter_name do |submission|
      submission.submitter.try(:name)
    end
    column :is_public
    column :created_at
    column :updated_at
    column :contact_email
    column :volunteers_needed
    column :budget_needed
    column :year
    column :votes do |submission|
      submission.votes.size
    end
    column :comment_count do |submission|
      submission.comments.size
    end
    column(:state) do |submission|
      submission.state.to_s.titleize
    end
  end

  filter :title
  filter :description
  filter :track
  filter :venue
  filter :format
  filter :submitter
  filter :start_day, as: :select, collection: Submission::DAYS
  filter :end_day, as: :select, collection: Submission::DAYS
  filter :time_range, as: :select, collection: Submission::TIME_RANGES
  filter :format, as: :select, collection: Submission::FORMATS

  form do |f|
    f.inputs do
      f.input :year
      f.input :submitter_id, as: :select, collection: User.order(:name).map {|t| [ t.name, t.id ]}, include_blank: false
      f.input :track_id, as: :select, collection: Track.all.map {|t| [ t.name, t.id ]}, include_blank: false
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
      f.input :budget_needed
      f.input :volunteers_needed
      f.input :notes
    end
    f.actions
  end

  sidebar :actions, only: [ :edit, :show ]  do
    link_to 'View on site', submission
  end

  sidebar 'Status', except: :index do
    status_tag submission.state.to_s.titleize, status_for_submission(submission)
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

  # State machine actions
  action_item :only => :show do
    unless submission.on_hold?
      link_to('Place on hold', place_on_hold_admin_submission_path(submission), method: :post)
    end
  end

  member_action :place_on_hold, method: :post do
    submission = Submission.find(params[:id])
    submission.place_on_hold!
    redirect_to admin_submission_path(submission)
  end

  action_item :only => [ :edit, :show ] do
    unless submission.open_for_voting?
      link_to('Open for voting', open_for_voting_admin_submission_path(submission), method: :post)
    end
  end

  member_action :open_for_voting, method: :post do
    submission = Submission.find(params[:id])
    submission.open_for_voting!
    redirect_to admin_submission_path(submission)
  end

  action_item :only => [ :edit, :show ] do
    if submission.open_for_voting?
      link_to('Accept', accept_admin_submission_path(submission), method: :post)
    end
  end

  member_action :accept, method: :post do
    submission = Submission.find(params[:id])
    submission.accept!
    redirect_to admin_submission_path(submission)
  end

  action_item :only => [ :edit, :show ] do
    if submission.accepted?
      link_to('Confirm', confirm_admin_submission_path(submission), method: :post)
    end
  end

  member_action :confirm, method: :post do
    submission = Submission.find(params[:id])
    submission.confirm!
    redirect_to admin_submission_path(submission)
  end

  action_item :only =>  [ :edit, :show ] do
    if submission.open_for_voting?
      link_to('Reject', reject_admin_submission_path(submission), method: :post)
    end
  end

  member_action :reject, method: :post do
    submission = Submission.find(params[:id])
    submission.reject!
    redirect_to admin_submission_path(submission)
  end

  batch_action :open_for_voting do |submissions|
    Submission.find(submissions).each do |submission|
      submission.open_for_voting!
    end
    redirect_to admin_submissions_path
  end

  batch_action :accept do |submissions|
    Submission.find(submissions).each do |submission|
      submission.accept!
    end
    redirect_to admin_submissions_path
  end

  batch_action :reject do |submissions|
    Submission.find(submissions).each do |submission|
      submission.reject!
    end
    redirect_to admin_submissions_path
  end

end
