namespace :recommendations do
  task refresh: :environment do
    Submission.for_current_year.for_schedule.find_each do |s|
      message = "Regenerated recommendations for #{s.id}: #{s.title}"
      ms = Benchmark.ms do
        s.refresh_similar_item_cache!
      end
      puts '%s (%.1fms)' % [ message, ms ]
    end
  end
end
