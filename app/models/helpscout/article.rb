module Helpscout
  class Article
    ARTICLE_CACHE_KEY = 'helpscout-article-cache'.freeze

    def initialize(json_data)
      @data = json_data
    end

    def name
      @data['name']
    end

    def content
      @data['text']
    end

    def self.fetch!
      data = helpscout_client.articles.map do |id|
        helpscout_client.article_details(id)
      end

      Redis.current.set(ARTICLE_CACHE_KEY, data.to_json)
    end

    def self.all
      JSON.parse(Redis.current.get(ARTICLE_CACHE_KEY) || '[]').map do |article|
        Article.new(article)
      end
    end

    def self.helpscout_client
      @client ||= Helpscout::Client.new
    end
  end
end
