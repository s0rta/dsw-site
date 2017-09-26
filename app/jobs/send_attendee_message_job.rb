class SendAttendeeMessageJob

  include Sidekiq::Worker

  def perform(attendee_message_id)
    attendee_message = AttendeeMessage.find(attendee_message_id)
    attendee_message.submission.registrants.find_in_batches(batch_size: 500) do |users|
      with_retries(max_tries: 5) do
        NotificationsMailer.send_attendee_message(attendee_message, users).deliver_now
      end
    end
    attendee_message.update_column :sent_at, Time.zone.now
  end
end
