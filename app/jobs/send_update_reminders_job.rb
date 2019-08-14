class SendUpdateRemindersJob
  include Sidekiq::Worker

  def perform
    scope = Submission
      .for_current_year
      .where.not(proposed_updates: nil)
    scope = if AnnualSchedule.voting_open?
      scope.where(state: "open_for_voting")
    else
      scope.where(state: %w[accepted confirmed venue_confirmed])
    end
    scope.each do |s|
      s.notify_track_chairs_of_update!(true)
    end
  end
end
