class Users::SessionsController < Devise::SessionsController

  def new
    @fullscreen_takeover = true
    super
  end
end
