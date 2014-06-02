class RegistrationsController < ApplicationController

  def new
    redirect_to closed_registration_path unless FeatureToggler.registration_active?
    @registration = Registration.new({ contact_email: current_user.try(:email) }.merge(registration_params))
  end

  def create
    @registration = current_user.registrations.new(params[:registration])
    if @registration.save
      redirect_to confirm_registration_path
    else
      respond_with @registration
    end
  end

  private

  def registration_params
    params[:registration] || {}
  end

end
