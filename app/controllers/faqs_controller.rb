class FaqsController < ApplicationController
  respond_to :html

  def index
    @articles = Helpscout::Article.all
  end
end
