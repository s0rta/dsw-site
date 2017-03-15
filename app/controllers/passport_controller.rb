require './app/lib/passport'

class PassportController < ApplicationController

  respond_to :html

  before_filter :setup

  def setup
    @passport_auth = Inversoft::Auth.new
  end

  def login

  end

  def do_login
    user = params.require(:user)
    @passport_auth.login(user[:email], user[:password])
    redirect_to schedules_path, notice: "Welcome back #{user[:email]}, good to see you."
  end

  def register

  end

  def do_register
    user = params.require(:user)

    # TODO Verify Confirm Password Matches before registering
    @passport_auth.register(user[:name], user[:email], user[:password])
    redirect_to schedules_path, notice: 'Thanks for registering! You will receive a confirmation e-mail shortly.'
  end

  def forgot_password

  end

  def do_forgot_password
    email = params.require(:email)
    @passport_auth.forgot_password(email)
  end
  
end
