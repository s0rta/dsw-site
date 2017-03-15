require './app/lib/passport'

class PassportController < ApplicationController

  respond_to :html

  def login

  end

  def do_login
    user = params.require(:user)

    passport_auth = Inversoft::Auth.new
    passport_auth.login(user[:email], user[:password])
  end

  def register

  end

  def do_register
    user = params.require(:user)

    # Verify Confirm Password Matches

    passport_auth = Inversoft::Auth.new
    passport_auth.register(user[:name], user[:email], user[:password])
  end

  def forgot_password

  end

  def do_forgot_password
    Rails.logger.debug params.inspect

    email = params.require(:email)

    passport_auth = Inversoft::Auth.new
    passport_auth.forgot_password(email)
  end
  
end
