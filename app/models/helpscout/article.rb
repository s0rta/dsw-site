module Helpscout
  class Article
    CACHE_KEY_PREFIX = 'helpscout-article-cache'.freeze

    def initialize(json_data)
      @data = json_data
    end

    def name
      @data['name']
    end

    def content
      @data['text']
    end

    class << self

      def fetch!
        helpscout_client.categories.each do |category_id, name|
          data = helpscout_client.category_articles(category_id).map do |article_id|
            helpscout_client.article_details(article_id)
          end

          Redis.current.set(cache_key_for_category(name), data.to_json)
        end
      end

      def for_category(name)
        JSON.parse(Redis.current.get(cache_key_for_category(name)) || '[]').map do |article|
          Article.new(article)
        end
      end

      def helpscout_client
        @client ||= Helpscout::Client.new
      end

      private

      def cache_key_for_category(name)
        [ CACHE_KEY_PREFIX, name.parameterize ].join('/')
      end

    end
  end
end
