class Users::RegistrationsController < Devise::RegistrationsController
  before_action :check_captcha, only: [:create]

  protected

  def after_sign_up_path_for(resource)
    after_sign_in_path_for(resource)
  end

  def after_update_path_for(resource)
    dashboard_path
  end

  private

  # Per https://github.com/plataformatec/devise/wiki/How-To:-Use-Recaptcha-with-Devise
  def check_captcha
    unless verify_recaptcha(action: "registration")
      self.resource = resource_class.new sign_up_params
      resource.validate # Look for any other validation errors besides Recaptcha
      set_minimum_password_length
      respond_with resource
    end
  end
end
