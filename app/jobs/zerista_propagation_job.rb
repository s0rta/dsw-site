class ZeristaPropagationJob
  include SuckerPunch::Job

  def perform(submission_id)
    ActiveRecord::Base.connection_pool.with_connection do
      Submission.find(submission_id).propagate_to_zerista
    end
  end
end
