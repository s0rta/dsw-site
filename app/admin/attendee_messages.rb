ActiveAdmin.register AttendeeMessage do

  config.sort_order = 'attendee_messages.created_at DESC'

  belongs_to :submission, optional: true

  permit_params :submission_id,
                :subject,
                :body

  menu parent: 'Sessions', priority: 3

  controller do
    def scoped_collection
      end_of_association_chain.includes(:submission)
    end
  end

  index do
    selectable_column
    column :submission
    column :subject
    column :sent_status
    column :author do |m|
      if user = User.where(id: m.paper_trail.originator).first
        link_to user.name, admin_user_path(user)
      else
        'Unknown'
      end
    end
    actions
  end

  filter :subject
  filter :body
  filter :submission

  action_item :deliver, only: %i(edit show) do
    unless attendee_message.sent?
      link_to 'Send',
              deliver_admin_attendee_message_path(attendee_message),
              method: :post
    end
  end

  form do |f|
    f.inputs do
      f.input :submission_id,
              as: :select,
              collection: Submission.
                          for_current_year.
                          where(state: %w(confirmed venue_confirmed withdrawn)).
                          order(:title),
              include_blank: false
      f.input :subject, hint: 'Must not exceed 100 characters'
      f.input :body
    end
    f.actions
  end

  member_action :deliver, method: :post do
    msg = AttendeeMessage.find(params[:id])
    SendAttendeeMessageJob.perform_async(msg)
    redirect_to admin_attendee_message_path(msg), notice: 'Send in progress!'
  end

  batch_action :deliver do |message_ids|
    AttendeeMessage.find(message_ids).each do |msg|
      SendAttendeeMessageJob.perform_async(msg)
    end
    redirect_to admin_attendee_messages_path
  end
end
