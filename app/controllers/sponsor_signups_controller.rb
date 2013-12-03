class SponsorSignupsController < ApplicationController

  respond_to :json

  def create
    @sponsor_signup = SponsorSignup.new(params[:sponsor_signup])
    if @sponsor_signup.save
      render json: nil, status: :ok
    else
      render json: @sponsor_signup.errors, status: :unprocessable_entity
    end
  end

end
