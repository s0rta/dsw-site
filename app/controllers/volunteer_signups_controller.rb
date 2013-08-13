class VolunteerSignupsController < ApplicationController

  respond_to :json

  def create
    @volunteer_signup = VolunteerSignup.new(params[:volunteer_signup])
    if @volunteer_signup.save
      render json: nil, status: :ok
    else
      render json: @volunteer_signup.errors, status: :unprocessable_entity
    end
  end

end
