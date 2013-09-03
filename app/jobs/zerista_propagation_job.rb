class ZeristaPropagationJob
  include SuckerPunch::Job

  def perform(submission_id)
    ActiveRecord::Base.connection_pool.with_connection do
      if submission = Submission.find_by_id(submission_id)
        submission.propagate_to_zerista
      else
        Zerista::Client.new(ENV['ZERISTA_SUBDOMAIN'], ENV['ZERISTA_KEY_ID'], ENV['ZERISTA_SIGNING_KEY']).delete_event_by_client_id submission_id
      end
    end
  end
end
