class ArticlesController < ApplicationController
  before_action :authenticate_user!, only: %i[new create update]

  def index
    @articles = Article.all
  end

  def show
    @article = Article.find(params[:id].to_i)
  end

  def new
    @article = Article.new(author_id: current_user.id)
  end

  def create
  end

  def update
  end

  def article_params
    params.require(:article).permit(
      :title,
      :body,
      :track_ids
    )
  end
end
