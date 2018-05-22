class VenuesController < ApplicationController
  before_action :set_venue, only: %i[show edit update destroy]

  # GET /venues
  def index
    @venues = Venue.all
    p Venue
  end

  # GET /venues/1
  def show; end

  # GET /venues/new
  def new
    @venue = Venue.new
  end

  # GET /venues/1/edit
  def edit; end

  # POST /venues
  def create
    @venue = Venue.new(venue_params)

    if @venue.save
      respond_with @venue, notice: 'Venue was successfully created.'
    else
      render :new
    end
  end

  # PATCH/PUT /venues/1
  def update
    if @venue.update(venue_params)
      respond_with @venue, notice: 'Venue was successfully updated.'
    else
      render :edit
    end
  end

  # DELETE /venues/1
  def destroy
    @venue.destroy
    redirect_to venues_url, notice: 'Venue was successfully destroyed.'
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_venue
    @venue = Venue.find(params[:id])
  end

  def venue_params
    params.require(:venue).permit(
      :name,
      :description,
      :address,
      :suite_or_unit,
      :city,
      :state,
      :seated_capacity,
      :standing_capacity,
      :av_capabilities,
      :extra_directions
    )
  end
end
