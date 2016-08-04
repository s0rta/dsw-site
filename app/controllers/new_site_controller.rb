class NewSiteController < ApplicationController

  before_filter :verify_page_exists!

  def index
    render template: "new_site/#{params[:page]}"
  end

  private

  def verify_page_exists!
    template_name = "new_site/#{sanitized_page}"
    unless template_exists?(template_name)
      raise ActionController::RoutingError.new("#{sanitized_page} not found")
    end
  end

  def sanitized_page
    @sanitized_page ||= Zaru.sanitize!(params[:page])
  end
end
