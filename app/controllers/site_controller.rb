class SiteController < ApplicationController
  respond_to :html
  rescue_from ActionView::MissingTemplate, with: :reraise_routing_error

  def index
    render template: page_partial
  end

  private

  def page_partial
    template_name = "site/#{params[:page].presence || "index"}".underscore
    lookup_context.find(template_name).virtual_path
  end

  def reraise_routing_error
    raise ActionController::RoutingError.new("Template not found")
  end
end
