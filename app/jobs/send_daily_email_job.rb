class SendDailyEmailJob

  include Sidekiq::Worker

  def perform(registration_id, day)
    registration = Registration.find(registration_id)
    DailyScheduleMailer.send("notify_of_#{day}_daily_schedule", registration).deliver_now!
  end
end
