module GivetooHelper
  def publishings_for_givetoo
    @publishings = Publishing.filtered_results(params).page(params[:page]).per(12)
  end
end
