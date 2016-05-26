class SponsorSignupsController < ApplicationController

  respond_to :json

  def create
    @sponsor_signup = SponsorSignup.new(sponsor_signup_params)
    if @sponsor_signup.save
      render json: nil, status: :ok
    else
      render json: @sponsor_signup.errors, status: :unprocessable_entity
    end
  end

  private

  def sponsor_signup_params
    params.require(:sponsor_signup).permit(:contact_email,
                                           :contact_name,
                                           :company,
                                           :interest,
                                           :notes)
  end

end
