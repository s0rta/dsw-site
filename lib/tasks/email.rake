namespace :email do

  task :notify_of_acceptance => :environment do
    Submission.for_current_year.where(state: 'accepted').each do |submission|
      Rails.logger.info "Sending acceptance notification to submission #{submission.id}"
      NotificationsMailer.notify_of_submission_acceptance(submission ).deliver_now!
      submission.update_column :notes, submission.notes + "\nSent acceptance e-mail on #{Date.today.to_s(:long)}"
    end
  end

  task :notify_of_rejection => :environment do
    Submission.for_current_year.where(state: 'rejected').each do |submission|
      Rails.logger.info "Sending rejection notification to submission #{submission.id}"
      NotificationsMailer.notify_of_submission_rejection(submission ).deliver_now!
      submission.update_column :notes, submission.notes + "\nSent rejection e-mail on #{Date.today.to_s(:long)}"
    end
  end

  task :notify_of_waitlisting => :environment do
    Submission.for_current_year.where(state: 'waitlisted').each do |submission|
      Rails.logger.info "Sending waitlisted notification to submission #{submission.id}"
      NotificationsMailer.notify_of_submission_waitlisting(submission ).deliver_now!
      submission.update_column :notes, submission.notes + "\nSent waitlisting e-mail on #{Date.today.to_s(:long)}"
    end
  end

  task :monday_schedule => :environment do
    Registration.
      for_current_year.
      joins(:submissions).
      where(submissions: { start_day: 2 }).
      having('COUNT(submissions.*) > 0').
      group('registrations.id').
      order('registrations.id').each do |registration|
        Rails.logger.info "Sending daily e-mail to registration #{registration.id}"
        NotificationsMailer.notify_of_monday_daily_schedule(registration).deliver_now!
      end
  end

  task :tuesday_schedule => :environment do
    Registration.
      for_current_year.
      joins(:submissions).
      where(submissions: { start_day: 3 }).
      having('COUNT(submissions.*) > 0').
      group('registrations.id').
      order('registrations.id').each do |registration|
        Rails.logger.info "Sending daily e-mail to registration #{registration.id}"
        NotificationsMailer.notify_of_tuesday_daily_schedule(registration).deliver_now!
      end
  end

  task :wednesday_schedule => :environment do
    Registration.
      for_current_year.
      joins(:submissions).
      where(submissions: { start_day: 4 }).
      having('COUNT(submissions.*) > 0').
      group('registrations.id').
      order('registrations.id').each do |registration|
        Rails.logger.info "Sending daily e-mail to registration #{registration.id}"
        NotificationsMailer.notify_of_wednesday_daily_schedule(registration).deliver_now!
      end
  end

  task :thursday_schedule => :environment do
    Registration.
      for_current_year.
      joins(:submissions).
      where(submissions: { start_day: 5 }).
      having('COUNT(submissions.*) > 0').
      group('registrations.id').
      order('registrations.id').each do |registration|
        Rails.logger.info "Sending daily e-mail to registration #{registration.id}"
        NotificationsMailer.notify_of_thursday_daily_schedule(registration).deliver_now!
      end
  end

  task :friday_schedule => :environment do
    Registration.
      for_current_year.
      joins(:submissions).
      where(submissions: { start_day: 6 }).
      having('COUNT(submissions.*) > 0').
      group('registrations.id').
      order('registrations.id').each do |registration|
        Rails.logger.info "Sending daily e-mail to registration #{registration.id}"
        NotificationsMailer.notify_of_friday_daily_schedule(registration).deliver_now!
      end
  end
end
