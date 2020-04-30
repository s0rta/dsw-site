class GivetoosController < ApplicationController
  skip_before_action :store_location, only: %i[new edit]

  def index
    @publishings = Publishing.filtered_results(params).page(params[:page]).per(12)

    respond_to do |format|
      format.html
    end
  end
end
