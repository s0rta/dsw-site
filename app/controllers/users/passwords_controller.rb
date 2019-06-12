class Users::PasswordsController < Devise::PasswordsController
  def new
    @fullscreen_takeover = true
    super
  end

  def edit
    @fullscreen_takeover = true
    super
  end
end
