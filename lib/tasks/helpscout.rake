namespace :helpscout do
  task :fetch_articles => :environment do
    Helpscout::Article.fetch!
  end
end
