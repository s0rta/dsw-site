class NewsletterSignupsController < ApplicationController

  respond_to :json

  def create
    @newsletter_signup = NewsletterSignup.new(params[:newsletter_signup])
    if @newsletter_signup.save
      head :ok
    else
      render json: @newsletter_signup.errors, status: :unprocessable_entity
    end
  end

end
