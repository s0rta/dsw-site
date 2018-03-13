module Helpscout
  class Client
    include HTTParty

    BASE_URI = 'https://docsapi.helpscout.net/v1'.freeze

    base_uri BASE_URI

    def articles
      data = self.class.get('/categories/5aa2b5f02c7d3a75495181d5/articles', basic_auth: auth)

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
  end
end
