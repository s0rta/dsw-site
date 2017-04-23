ActiveAdmin.register Submission do

  menu parent: 'Sessions', priority: 1

  permit_params :start_day,
                :end_day,
                :year,
                :description,
                :format,
                :location,
                :notes,
                :internal_notes,
                :time_range,
                :title,
                :track_id,
                :contact_email,
                :estimated_size,
                :is_public,
                :is_confirmed,
                :venue_id,
                :cluster_id,
                :budget_needed,
                :volunteers_needed,
                :start_hour,
                :end_hour,
                :state,
                :submitter_id,
                :slides_url,
                :video_url,
                :company_name

  controller do
    def scoped_collection
      resource_class.includes(:track,
                              :submitter,
                              :votes,
                              :venue,
                              :cluster)
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
    column :cluster, sortable: 'clusters.name'
    column :venue, sortable: 'venues.name'
    column('Time', sortable: 'start_hour') do |s|
      "#{s.human_start_day} #{s.human_time_range}".html_safe if s.time_assigned?
    end
    column('Status', sortable: :state) do |s|
      status_tag s.state.to_s.titleize, status_for_submission(s)
    end
    column :submitter, sortable: 'users.name'
    column(:votes, sortable: 'COUNT(votes.id)') { |s| s.votes.size }
    column(:pending_updates, sortable: false) { |s| s.proposed_updates.present? ? 'Yes' : 'No' }
    actions
  end

  csv do
    column :id
    column :title
    column :description
    column :notes
    column :internal_notes
    column :track do |submission|
      submission.track.try(:name)
    end
    column :cluster do |submission|
      submission.cluster.try(:name)
    end
    column :venue do |submission|
      submission.venue.try(:name)
    end
    column :format
    column(:start_day) { |s| s.human_start_day }
    column(:start_time) { |s| s.human_start_time }
    column(:end_day) { |s| s.human_end_day }
    column(:end_time) { |s| s.human_end_time }
    column :submitter_name do |submission|
      submission.submitter.try(:name)
    end
    column :created_at
    column :updated_at
    column :company_name
    column :contact_email
    column :estimated_size
    column :volunteers_needed
    column :budget_needed
    column :year
    column :registrants do |submission|
      submission.registrants.size
    end
    column :votes do |submission|
      submission.votes.size
    end
    column(:state) do |submission|
      submission.state.to_s.titleize
    end
    column(:venue_name) do |s|
      s.venue.try(:name)
    end
    column(:venue_address) do |s|
      s.venue.try(:combined_address)
    end
  end

  filter :title
  filter :description
  filter :track
  filter :venue, as: :select, collection: -> { Venue.alphabetical }
  filter :company_name
  filter :format
  filter :submitter_name_cont, as: :string, label: 'Submitter Name'
  filter :start_day, as: :select, collection: Submission::DAYS.invert
  filter :end_day, as: :select, collection: Submission::DAYS.invert
  filter :time_range, as: :select, collection: Submission::TIME_RANGES
  filter :format, as: :select, collection: Submission::FORMATS
  filter :state, as: :select, collection: -> { Submission.states }
  filter :cluster, as: :select, collection: -> { Cluster.all }

  form do |f|
    f.inputs do
      f.input :year
      f.input :submitter_id, as: :select, collection: User.order(:name).map {|t| [ t.name, t.id ]}, include_blank: false
      f.input :track_id, as: :select, collection: Track.all.map {|t| [ t.name, t.id ]}, include_blank: false
      f.input :state, as: :select, collection: Submission.states, include_blank: false
      f.input :format, as: :select, collection: Submission::FORMATS, include_blank: true
      f.input :time_range, as: :select, label: 'Submitted Time Range', collection: Submission::TIME_RANGES, include_blank: true, input_html: { disabled: true }
      f.input :start_day, as: :select, collection: Submission::DAYS.invert, include_blank: true
      f.input :start_hour, as: :select, collection: collection_for_hour_select, include_blank: false
      f.input :end_day, as: :select, collection: Submission::DAYS.invert, include_blank: true
      f.input :end_hour, as: :select, collection: collection_for_hour_select, include_blank: false
      f.input :venue_id, as: :select, collection: Venue.alphabetical.map {|v| [ v.name, v.id ]}, include_blank: true
      f.input :cluster_id, as: :select, collection: Cluster.all.map {|c| [ c.name, c.id ]}, include_blank: true
      f.input :title
      f.input :description
      f.input :location
      f.input :contact_email
      f.input :company_name
      f.input :estimated_size
      f.input :budget_needed
      f.input :volunteers_needed
      f.input :notes
      f.input :internal_notes
      f.input :slides_url
      f.input :video_url
    end
    f.actions
  end

  sidebar :actions, only: [ :edit, :show ]  do
    para { link_to('View in panel picker', submission_path(submission)) }
    para { link_to('View in schedule', schedule_path(id: submission.id)) }
  end

  sidebar 'Status', except: :index do
    status_tag submission.state.to_s.titleize, status_for_submission(submission)
  end

  sidebar :versionate, partial: 'admin/version', only: :show

  # Attendee export
  sidebar 'Attendees', except: :index do
    "#{submission.registrants.count} attending"
  end

  action_item only: [ :edit, :show ] do
    link_to 'Export attendee list', export_attendees_admin_submission_path(submission)
  end

  member_action :export_attendees, method: :get do
    registrations = Submission.find(params[:id]).user_registrations.includes(:user)
    csv_text = CSV.generate do |csv|
      registrations.each do |registration|
        csv << [ registration.user.name,
                 registration.primary_role,
                 registration.user.email,
                 registration.zip,
                 registration.gender ]
      end
    end
    render csv: csv_text
  end

  show do
    if submission.proposed_updates
      panel 'Proposed Updates' do
        attributes_table_for submission do
          submission.proposed_updates.keys.each do |k|
            row k do
              submission.proposed_updates[k]
            end
          end
        end
      end
    end

    attributes_table(*(default_attribute_table_rows - [:proposed_updates]))

    panel 'Recent Updates' do
      table_for submission.versions do
        column 'Modified at' do |v|
          v.created_at.to_s :long
        end
        column 'User' do |v|
          if user = User.where(id: v.whodunnit).first
            link_to user.name, admin_user_path(user)
          else
            'Unknown'
          end
        end
        column 'View' do |v|
          link_to 'View', { version: v.index}
        end
      end
    end
  end

  # Notify of venue match
  action_item only: :show do
    if submission.venue && submission.venue.contact_email && submission.contact_email && submission.venue.contact_name
      link_to('Send venue match email', send_venue_match_email_admin_submission_path(submission), method: :post)
    end
  end

  member_action :send_venue_match_email, method: :post do
    submission = Submission.find(params[:id])
    NotificationsMailer.notify_of_submission_venue_match(submission).deliver_now
    flash[:notice] = 'Email sent!'
    submission.update_column :notes, submission.notes + "\nSent venue match e-mail on #{Date.today.to_s(:long)}"
    redirect_to admin_submission_path(submission)
  end

  # Accept proposed session changes
  action_item only: :show do
    if submission.proposed_updates
      link_to('Accept updates', accept_update_admin_submission_path(submission), method: :post)
    end
  end

  member_action :accept_update, method: :post do
    submission = Submission.find(params[:id])
    submission.promote_updates
    redirect_to admin_submission_path(submission)
  end

  # State machine actions
  action_item only: :show do
    unless submission.on_hold?
      link_to('Place on hold', place_on_hold_admin_submission_path(submission), method: :post)
    end
  end

  member_action :place_on_hold, method: :post do
    submission = Submission.find(params[:id])
    submission.place_on_hold!
    redirect_to admin_submission_path(submission)
  end

  action_item only: [ :edit, :show ] do
    unless submission.open_for_voting?
      link_to('Open for voting', open_for_voting_admin_submission_path(submission), method: :post)
    end
  end

  member_action :open_for_voting, method: :post do
    submission = Submission.find(params[:id])
    submission.open_for_voting!
    redirect_to admin_submission_path(submission)
  end

  action_item only: [ :edit, :show ] do
    if submission.open_for_voting?
      link_to('Accept', accept_admin_submission_path(submission), method: :post)
    end
  end

  member_action :accept, method: :post do
    submission = Submission.find(params[:id])
    submission.accept!
    redirect_to admin_submission_path(submission)
  end

  action_item only: [ :edit, :show ] do
    if submission.accepted?
      link_to('Confirm', confirm_admin_submission_path(submission), method: :post)
    end
  end

  member_action :confirm, method: :post do
    submission = Submission.find(params[:id])
    submission.confirm!
    redirect_to admin_submission_path(submission)
  end

  action_item only: [ :edit, :show ] do
    link_to('Withdraw', withdraw_admin_submission_path(submission), method: :post)
  end

  member_action :withdraw, method: :post do
    submission = Submission.find(params[:id])
    submission.withdraw!
    redirect_to admin_submission_path(submission)
  end

  action_item only: [ :edit, :show ] do
    if submission.open_for_voting?
      link_to('Reject', reject_admin_submission_path(submission), method: :post)
    end
  end

  member_action :reject, method: :post do
    submission = Submission.find(params[:id])
    submission.reject!
    redirect_to admin_submission_path(submission)
  end

  member_action :waitlist, method: :post do
    submission = Submission.find(params[:id])
    submission.waitlist!
    redirect_to admin_submission_path(submission)
  end

  action_item only: [ :edit, :show ] do
    if submission.open_for_voting?
      link_to('Waitlist', waitlist_admin_submission_path(submission), method: :post)
    end
  end

  batch_action :open_for_voting do |submissions|
    Submission.find(submissions).each(&:open_for_voting!)
    redirect_to admin_submissions_path
  end

  batch_action :accept do |submissions|
    Submission.find(submissions).each(&:accept!)
    redirect_to admin_submissions_path
  end

  batch_action :reject do |submissions|
    Submission.find(submissions).each(&:reject!)
    redirect_to admin_submissions_path
  end

  batch_action :waitlist do |submissions|
    Submission.find(submissions).each(&:waitlist!)
    redirect_to admin_submissions_path
  end

  batch_action :withdraw do |submissions|
    Submission.find(submissions).each(&:withdraw!)
    redirect_to admin_submissions_path
  end

  batch_action :confirm do |submissions|
    Submission.find(submissions).each(&:confirm!)
    redirect_to admin_submissions_path
  end

  # Hooks
  after_build do |submission|
    submission.submitter ||= current_user
  end
end
