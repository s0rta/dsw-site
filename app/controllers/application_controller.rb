class ApplicationController < ActionController::Base

  respond_to :html
  helper_method :user_signed_in?
  helper_method :in_mercury_invasion?
  protect_from_forgery

  def user_signed_in?
    request.headers["Authorization"].present?
  end

  def in_mercury_invasion?
    params[:mercury_frame] && (params[:mercury_frame] == true || params[:mercury_frame] == 'true')
  end

end
