class ArticlesController < ApplicationController
  before_action :authenticate_user!, only: %i[new create update]

  def index
    @articles = Article.all
  end

  def show
    @article = Article.find(params[:id].to_i)
  end

  def new
    @article = Article.new
  end

  def create
    @article = current_user.articles.new(article_params)
    if @article.save
      flash[:notice] = "Thanks! Your article has been received!"
      redirect_to dashboard_path
    else
      respond_with @article
    end
  end

  def update
  end

  def article_params
    params.require(:article).permit(
      :title,
      :body,
      :track_ids,
      :header_image
    )
  end
end
