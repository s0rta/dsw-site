class VenueAvailabilitiesController < ApplicationController
  before_action :set_venue_availability, only: %i[update]

  # PATCH/PUT /venues/1
  def update
    @venue_availability.update(submission_id: params[:submission_id])
    if @venue_availability.save
      flash[:notice] = 'Submission has been assigned to a venue_availability'
      redirect_back(fallback_location: root_path )
    else 
      flash[:error] = 'Something went wrong with assigning this submission to a venue availability. Are you sure it has not already been assigned?'
      redirect_back(fallback_location: root_path )
    end

  end

  def set_venue_availability
    @venue_availability = VenueAvailability.find(params[:id])
  end
end
