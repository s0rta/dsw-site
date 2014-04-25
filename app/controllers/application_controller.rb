require "application_responder"

class ApplicationController < ActionController::Base

  self.responder = ApplicationResponder
  respond_to :html

  helper_method :user_signed_in?
  helper_method :current_user
  helper_method :current_body_class
  helper_method :in_mercury_invasion?

  protect_from_forgery

  private

  def user_signed_in?
    request.headers["Authorization"].present?
  end

  def ensure_linkedin_and_admin!
    if current_user && !current_user.is_admin?
      redirect_to '/'
    elsif !current_user
      redirect_to '/auth/linkedin'
    end
  end

  def in_mercury_invasion?
    params[:mercury_frame] && (params[:mercury_frame] == true || params[:mercury_frame] == 'true')
  end

  def current_user
    session[:current_user_id] && User.where(id: session[:current_user_id]).first
  end

  def signed_in?
    session[:current_user_id].present?
  end

  def current_body_class
    if respond_to?(:current_page)
      current_page.try(:template)
    else
      controller_name
    end
  end

  def user_for_paper_trail
    current_user || 'Unknown user'
  end

end
