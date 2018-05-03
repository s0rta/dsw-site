module Helpscout
  class Client
    include HTTParty

    BASE_URI = 'https://docsapi.helpscout.net/v1'.freeze

    base_uri BASE_URI

    def categories
      data = self.class.get("/collections/#{collection_id}/categories", basic_auth: auth)
      data.dig('categories', 'items').each_with_object({}) do |category, hash|
        hash[category['id']] = category['name']
      end
    end

    def category_articles(category_id)
      data = self.class.get("/categories/#{category_id}/articles", basic_auth: auth)
      data.dig('articles', 'items').map do |article|
        article['id']
      end
    end

    def article_details(article_id)
      data = self.class.get("/articles/#{article_id}", basic_auth: auth)
      data['article']
    end

    private

    def auth
      @auth ||= { username: ENV['HELPSCOUT_DOCS_KEY'], password: 'X' }
    end

    def collection_id
      @collection_id ||= ENV['HELPSCOUT_DOCS_COLLECTION_ID']
    end
  end
end
