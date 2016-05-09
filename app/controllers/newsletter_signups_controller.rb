class NewsletterSignupsController < ApplicationController

  respond_to :json

  def create
    @newsletter_signup = NewsletterSignup.new(newsletter_signup_params)
    if @newsletter_signup.save
      render json: nil, status: :ok
    else
      render json: @newsletter_signup.errors, status: :unprocessable_entity
    end
  end

  private

  def newsletter_signup_params
    params.require(:newsletter_signup).permit(:email)
  end

end
