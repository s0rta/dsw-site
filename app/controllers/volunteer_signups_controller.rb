class VolunteerSignupsController < ApplicationController

  respond_to :json

  def create
    @volunteer_signup = VolunteerSignup.new(volunteer_signup_params)
    if @volunteer_signup.save
      render json: nil, status: :ok
    else
      render json: @volunteer_signup.errors, status: :unprocessable_entity
    end
  end

  private

  def volunteer_signup_params
    params.require(:volunteer_signup).permit(:contact_email, :contact_name, :interest, :notes)
  end

end
