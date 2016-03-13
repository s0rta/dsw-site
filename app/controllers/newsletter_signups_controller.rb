class NewsletterSignupsController < ApplicationController

  respond_to :json

  def create
    @newsletter_signup = NewsletterSignup.new(params[:newsletter_signup])
    if @newsletter_signup.save
      render json: nil, status: :ok
    else
      render json: @newsletter_signup.errors, status: :unprocessable_entity
    end
  end

  private

  def newsletter_signup_params
    params.require(:newsletter_signup).permit(:email, :first_name, :last_name)
  end

end
