class NewSiteController < ApplicationController

  before_filter :verify_page_exists!

  def index
    render template: "new_site/#{params[:page]}"
  end

  private

  def verify_page_exists!
    unless template_exists?(params[:page], _prefixes, false)
      raise ActionController::RoutingError.new("#{params[:page]} not found")
    end
  end
end
