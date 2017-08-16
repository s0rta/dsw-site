module ActiveAdmin
  module ViewsHelper

    def collection_for_hour_select
      (0..48).map do |i|
        [
          (Time.now.at_beginning_of_day + (i.to_f/2).hours).strftime('%l:%M%P'),
          (i.to_f / 2)
        ]
      end
    end

    def status_for_submission(submission)
      status_type = nil
      status_type = :ok if submission.confirmed? || submission.venue_confirmed?
      status_type = :error if submission.rejected? || submission.withdrawn?
      status_type ||= :warning
      status_type
    end

  end
end
