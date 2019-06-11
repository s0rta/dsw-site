class Users::RegistrationsController < Devise::RegistrationsController
  def new
    @fullscreen_takeover = true
    super
  end

  def create
    @fullscreen_takeover = true
    super
  end

  protected

  def after_sign_up_path_for(resource)
    after_sign_in_path_for(resource)
  end

  def after_update_path_for(resource)
    edit_user_registration_path(resource)
  end
end
