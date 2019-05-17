class VenuesController < ApplicationController
  before_action :set_venue, only: %i[show edit update destroy]
  before_action :set_venue_availability, only: %i[create edit update]

  # GET /venues
  def index
    @venues = Venue.joins(company: :users).where(users: {id: current_user})
  end

  # GET /venues/1
  def show
  end

  # GET /venues/new
  def new
    @venue = Venue.new
  end

  # GET /venues/1/edit
  def edit
  end

  # POST /venues
  def create
    @venue = Venue.new(venue_params)

    if @venue.save
      params["venue_availability"]&.each do |day, times|
        times.each do |time, exists|
          toggle_venue_availability(day, time, exists, @venue.id)
        end
      end

      respond_with @venue, notice: "Venue was successfully created."
    else
      render :new
    end
  end

  # PATCH/PUT /venues/1
  def update
    if @venue.update(venue_params)
      params["venue_availability"]&.each do |day, times|
        times.each do |time, exists|
          toggle_venue_availability(day, time, exists, params[:id])
        end
      end

      respond_with @venue, notice: "Venue was successfully updated."
    else
      render :edit
    end
  end

  # DELETE /venues/1
  def destroy
    @venue.destroy
    redirect_to venues_url, notice: "Venue was successfully destroyed."
  end

  private

  def toggle_venue_availability(day, time, should_exists, venue_id)
    day = day.to_i
    time = time.to_i
    should_exists = ActiveModel::Type::Boolean.new.cast(should_exists)

    if should_exists
      if !@venue_availabilities || !@venue_availabilities.find { |availability| (availability.day == day) && (availability.time_block == time) }
        VenueAvailability.create(
          venue_id: venue_id,
          day: day,
          time_block: time,
        )
      end
    else
      existing_venue_availability = @venue_availabilities.find { |availability| (availability.day == day) && (availability.time_block == time) }
      if existing_venue_availability
        if existing_venue_availability["submission_id"]
          flash[:error] = "Could not remove availability, a session has already been assigned to it."
        else
          existing_venue_availability.delete
        end
      end
    end
  end

  # Use callbacks to share common setup or constraints between actions.
  def set_venue
    @venue = Venue.find(params[:id])
  end

  def set_venue_availability
    @venue_availabilities = VenueAvailability.where(venue_id: params[:id])
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
