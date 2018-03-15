class FetchHelpscoutArticlesJob

  include Sidekiq::Worker

  def perform
    Helpscout::Article.fetch!
  end
end
