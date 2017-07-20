class RegistrationsController < ApplicationController

  before_action :check_registration_open, except: [ :closed ]
  before_action :authenticate_user!, unless: :simple_registration?, except: [ :closed ]
  before_action :check_existing_registration, unless: :simple_registration?, except: [ :closed ]

  def new
    redirect_to closed_registration_path unless EventSchedule.registration_open?
    registration_attributes = { contact_email: current_user.try(:email) }.merge(registration_params)
    @registration = Registration.new(registration_attributes)
  end

  def create
    if simple_registration?
      password = SecureRandom.hex
      @registration = Registration.new(registration_params)
      @registration.user = User.first_or_initialize(email: registration_user_params[:email]) do |u|
        u.assign_attributes(password: password,
                            password_confirmation: password,
                            name: registration_user_params[:name])
      end
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
    params.fetch(:registration, {}).permit(:year,
                                           :zip,
                                           :company,
                                           :gender,
                                           :primary_role,
                                           :age_range,
                                           :track_id)
  end

  def registration_user_params
    params.fetch(:registration, {}).permit(:name,
                                           :email)
  end

  def check_registration_open
    redirect_to closed_registration_path unless EventSchedule.registration_open?
  end

  def check_existing_registration
    redirect_to schedules_path if registered?
  end
end
