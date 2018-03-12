class RefreshAllRecommendationsJob

  include Sidekiq::Worker

  def perform
    Submission.for_schedule.find_each do |s|
      message = "Regenerated recommendations for #{s.id}: #{s.title}"
      ms = Benchmark.ms do
        s.refresh_similar_item_cache!
      end
      Rails.logger.info '%s (%.1fms)' % [ message, ms ]
    end
  end
end
