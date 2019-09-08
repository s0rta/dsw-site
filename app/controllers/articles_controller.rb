class ArticlesController < ApplicationController
  skip_before_action :store_location, only: %i[new edit]
  before_action :authenticate_user!, only: %i[new create update edit]

  def index
    @publishings = Publishing.filtered_results(params).page(params[:page]).per(12)

    respond_to do |format|
      format.html
      format.js do
        render json: {fragment: render_to_string(partial: "layouts/shared/publishings_list_items",
                                                 locals: {list: @publishings}, formats: [:html]),
                      next_url: url_for(page: Integer(params[:page] || 1) + 1),
                      last_page: @publishings.last_page?,}
      end
    end
  end

  def show
    @article = Article.published.find(params[:id].to_i)
  end

  def new
    @article = current_user.articles.new
  end

  def create
    @article = current_user.articles.new(article_params.merge(author_ids: [article_params[:author_ids]]))
    noninteractive_success = verify_recaptcha(action: "create_article", model: @article)
    checkbox_success = verify_recaptcha(model: @article) unless noninteractive_success
    if noninteractive_success || checkbox_success
      # Perform action
      if @article.save
        flash[:notice] = "Thanks! Your article has been received."
        NotificationsMailer.notify_of_new_article(@article).deliver_now
        redirect_to dashboard_path
      else
        respond_with @article
      end
    else
      unless noninteractive_success
        @show_checkbox_recaptcha = true
      end
      render "new"
    end
  end

  def edit
    @article = current_user.articles.find(params[:id])
    if @article.submitter_id != current_user.id
      redirect_to dashboard_path
    else
      respond_with @article
    end
  end

  def update
    @article = current_user.articles.find(params[:id])
    @article.update(article_params)
    if @article.save
      flash[:notice] = "Thanks! Your article update has been received."
      redirect_to dashboard_path
    else
      respond_with @article
    end
  end

  private

  def article_params
    params.require(:article).except(:authors).permit(
      :title,
      :body,
      :header_image,
      :author_ids,
      track_ids: [],
    )
  end
end
