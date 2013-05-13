require "application_responder"

class ApplicationController < ActionController::Base
  self.responder = ApplicationResponder
  respond_to :html


  respond_to :html

  helper_method :user_signed_in?
  helper_method :current_user
  helper_method :current_body_class
  helper_method :in_mercury_invasion?

  protect_from_forgery

  def user_signed_in?
    request.headers["Authorization"].present?
  end

  def in_mercury_invasion?
    params[:mercury_frame] && (params[:mercury_frame] == true || params[:mercury_frame] == 'true')
  end

  def current_user
    User.where(id: session[:current_user_id]).first
  end

  def current_body_class
    if respond_to?(:current_page)
      current_page.try(:template)
    else
      controller_name
    end
  end

end
