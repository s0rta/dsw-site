class RegistrationsController < ApplicationController

  before_filter :authenticate_user!, unless: :simple_registration?

  def new
    redirect_to closed_registration_path unless FeatureToggler.registration_active?
    registration_attributes = { contact_email: current_user.try(:email) }.merge(registration_params)
    @registration = Registration.new(registration_attributes)
  end

  def create
    if simple_registration?
      password = SecureRandom.hex
      @registration = Registration.new(registration_params)
      @user = @registration.build_user(email: registration_params[:email], password: password, password_confirmation: password)
    else
      @registration = current_user.registrations.build(registration_params)
    end
    if @registration.save
      redirect_to schedules_path, notice: 'Thanks for registering! You will receive a confirmation e-mail shortly.'
    else
      respond_with @registration
    end
  end

  private

  def registration_params
    params.fetch(:registration, {}).permit(:contact_email,
                                           :year,
                                           :zip,
                                           :company,
                                           :gender,
                                           :primary_role,
                                           :track_id)
  end

end
