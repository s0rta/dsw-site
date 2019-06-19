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

  def edit
    @article = Article.find(params[:id])
  end

  def update
    @article = Article.find(params[:id])
    @article.update(article_params)
    if @article.save
      flash[:notice] = "Thanks! Your article update has been received!"
      redirect_to dashboard_path
    else
      respond_with @article
    end
  end

  def article_params
    params.require(:article).permit(
      :title,
      :body,
      :header_image,
      track_ids: []
    )
  end
end
