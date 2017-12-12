namespace :email do

  task notify_of_acceptance: :environment do
    Track.submittable.each do |t|
      Rails.logger.info "Processing submissions for #{t.name} track"
      t.submissions.for_current_year.where(state: 'accepted').each do |submission|
        Rails.logger.info "Sending acceptance notification to submission #{submission.id}"
        submission.send_accept_email!
      end
    end
  end

  task notify_of_rejection: :environment do
    Track.submittable.each do |t|
      t.submissions.for_current_year.where(state: 'rejected').each do |submission|
        Rails.logger.info "Sending rejection notification to submission #{submission.id}"
        submission.send_reject_email!
      end
    end
  end

  task notify_of_waitlisting: :environment do
    Track.submittable.each do |t|
      t.submissions.for_current_year.where(state: 'waitlisted').each do |submission|
        Rails.logger.info "Sending waitlisted notification to submission #{submission.id}"
        submission.send_waitlist_email!
      end
    end
  end

  task monday_schedule: :environment do
    Registration.
      for_current_year.
      joins(:submissions).
      where(submissions: { start_day: 2 }).
      having('COUNT(submissions.*) > 0').
      group('registrations.id').
      order('registrations.id').each do |registration|
        Rails.logger.info "Sending daily e-mail to registration #{registration.id}"
        SendDailyEmailJob.perform_async(registration.id, 'monday')
      end
  end

  task tuesday_schedule: :environment do
    Registration.
      for_current_year.
      joins(:submissions).
      where(submissions: { start_day: 3 }).
      having('COUNT(submissions.*) > 0').
      group('registrations.id').
      order('registrations.id').each do |registration|
        Rails.logger.info "Sending daily e-mail to registration #{registration.id}"
        SendDailyEmailJob.perform_async(registration.id, 'tuesday')
      end
  end

  task wednesday_schedule: :environment do
    Registration.
      for_current_year.
      joins(:submissions).
      where(submissions: { start_day: 4 }).
      having('COUNT(submissions.*) > 0').
      group('registrations.id').
      order('registrations.id').each do |registration|
        Rails.logger.info "Sending daily e-mail to registration #{registration.id}"
        SendDailyEmailJob.perform_async(registration.id, 'wednesday')
      end
  end

  task thursday_schedule: :environment do
    Registration.
      for_current_year.
      joins(:submissions).
      where(submissions: { start_day: 5 }).
      having('COUNT(submissions.*) > 0').
      group('registrations.id').
      order('registrations.id').each do |registration|
        Rails.logger.info "Sending daily e-mail to registration #{registration.id}"
        SendDailyEmailJob.perform_async(registration.id, 'thursday')
      end
  end

  task friday_schedule: :environment do
    Registration.
      for_current_year.
      joins(:submissions).
      where(submissions: { start_day: 6 }).
      having('COUNT(submissions.*) > 0').
      group('registrations.id').
      order('registrations.id').each do |registration|
        Rails.logger.info "Sending daily e-mail to registration #{registration.id}"
        SendDailyEmailJob.perform_async(registration.id, 'friday')
      end
  end

  task give_thanks: :environment do
    Submission.for_current_year.for_schedule.each do |submission|
      Rails.logger.info "Giving thanks to submission #{submission.id}"
      submission.send_thanks_email!
    end
  end

  namespace :sendgrid do
    task resync_subscriptions: :environment do
      sg = SendGrid::API.new(api_key: ENV['SENDGRID_API_KEY'])
      list_id = ENV['SENDGRID_LIST_ID']
      Rails.logger.info "Resyncing newsletter subscriptions (#{NewsletterSignup.count}) (1/3)"
      NewsletterSignup.find_in_batches(batch_size: 1000) do |batch|
        payload = batch.map do |ns|
          { email: ns.email, first_name: ns.first_name, last_name: ns.last_name }
        end
        response = sg.client.contactdb.recipients.post(request_body: payload)
        recipient_ids = JSON.parse(response.body)['persisted_recipients']
        response = sg.client.contactdb.lists._(list_id).recipients.post(request_body: recipient_ids)
      end
      Rails.logger.info "Resyncing session submissions (#{Submission.count}) (2/3)"
      Submission.find_in_batches(batch_size: 1000) do |batch|
        payload = batch.map do |s|
          { email: s.email }
        end
        response = sg.client.contactdb.recipients.post(request_body: payload)
        recipient_ids = JSON.parse(response.body)['persisted_recipients']
        response = sg.client.contactdb.lists._(list_id).recipients.post(request_body: recipient_ids)
      end
      Rails.logger.info "Resyncing registrations (#{Registration.count}) (3/3)"
      Registration.find_in_batches(batch_size: 1000) do |batch|
        payload = batch.map do |r|
          { email: r.email }
        end
        response = sg.client.contactdb.recipients.post(request_body: payload)
        recipient_ids = JSON.parse(response.body)['persisted_recipients']
        response = sg.client.contactdb.lists._(list_id).recipients.post(request_body: recipient_ids)
      end
    end
  end
end
