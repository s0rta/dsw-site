class GiveToo::ResourcesController < ApplicationController
  skip_before_action :store_location, only: %i[new edit]
  before_action :authenticate_user!, only: %i[new create update edit]

  def index
    @resources = Resource.filtered_results(params).page(params[:page]).per(12)

    respond_to do |format|
      format.html
      format.js do
        render json: {fragment: render_to_string(partial: "give_too/resources/list",
                                                 locals: {resources: @resources}, formats: [:html]),
                      next_url: url_for(page: Integer(params[:page] || 1) + 1),
                      last_page: @resources.last_page?,}
      end
    end
  end

  def show
    @resource = Resource.find(params[:id].to_i)
  end

  def new
    @resource = current_user.resources.new
    @url = give_too_resources_path
  end

  def create
    @resource = current_user.resources.new(resource_params)
    if verify_recaptcha(action: "create_resource",
                        model: @resource,
                        minimum_score: recaptcha_min_score) && @resource.save
      flash[:notice] = "Thanks! Your resource has been received."
      NotificationsMailer.notify_of_new_resource(@resource).deliver_now
      redirect_to dashboard_path
    else
      @url = give_too_resources_path
      respond_with @resource, location: @url
    end
  end

  def edit
    @resource = current_user.resources.find(params[:id])
    @url = give_too_resource_path
    if @resource.user_id != current_user.id
      redirect_to dashboard_path
    else
      respond_with @resource, location: @url
    end
  end

  def update
    @resource = current_user.resources.find(params[:id])
    @resource.update(resource_params)
    if @resource.save
      flash[:notice] = "Thanks! Your resource update has been received."
      redirect_to dashboard_path
    else
      @url = give_too_resource_path
      respond_with @resource, location: @url
    end
  end

  private

  def resource_params
    params.require(:resource).permit(
      :name,
      :description,
      :image,
      :industry_type_id,
      :contact_information,
      :website,
      :expiration_date,
      :company_id,
      support_area_ids: [],
    )
  end
end
