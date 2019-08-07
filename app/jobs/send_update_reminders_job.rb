class SendUpdateRemindersJob
  include Sidekiq::Worker

  def perform
    Submission.for_current_year.where.not(proposed_updates: nil).each do |s|
      s.notify_track_chairs_of_update!(true)
    end
  end
end
