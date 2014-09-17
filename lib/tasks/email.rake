namespace :email do

  task :monday_schedule => :environment do
    Registration.joins(:submissions).
      where(submissions: { start_day: 2 }).
      having('COUNT(submissions.*) > 0').
      group('registrations.id').each do |registration|
        NotificationsMailer.notify_of_monday_daily_schedule(registration).deliver!
      end
  end

  task :tuesday_schedule => :environment do
    Registration.joins(:submissions).
      where(submissions: { start_day: 3 }).
      having('COUNT(submissions.*) > 0').
      group('registrations.id').each do |registration|
        NotificationsMailer.notify_of_tuesday_daily_schedule(registration).deliver!
      end
  end

  task :wednesday_schedule => :environment do
    Registration.joins(:submissions).
      where(submissions: { start_day: 4 }).
      having('COUNT(submissions.*) > 0').
      group('registrations.id').each do |registration|
        NotificationsMailer.notify_of_wednesday_daily_schedule(registration).deliver!
      end
  end

end
