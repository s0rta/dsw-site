namespace :recommendations do
  namespace :refresh do
    task current: :environment do
      RefreshCurrentRecommendationsJob.new.perform
    end

    task all: :environment do
      RefreshAllRecommendationsJob.new.perform
    end
  end
end
