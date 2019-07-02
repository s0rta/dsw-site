class ClustersController < ApplicationController
  def show
    @cluster = Cluster.find_by(name: params[:name])
    @publishings = Publishing.filtered_results(cluster: params[:name]).page(params[:page]).per(24)

    respond_to do |format|
      format.html do
        render template: 'site/program/clusters/show'
      end

      format.js do
        render json: { fragment: render_to_string(partial: 'layouts/shared/publishings_list_items',
                       locals: { list: @publishings }, formats: [:html]),
                       next_url: url_for(page: Integer(params[:page] || 1) + 1),
                       last_page: @publishings.last_page? }
      end
    end
  end
end
