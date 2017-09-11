class NewSiteController < ApplicationController

  respond_to :html

  before_action :verify_page_exists!

  def index
    @ctas = HomepageCta.active.relevant_to_cycles(EventSchedule.active_cycles).in_priority_order
    render template: "new_site/#{page_name}"
  end

  private

  def page_name
    params[:page].presence || 'index'
  end

  def verify_page_exists!
    unless template_exists?(page_name, _prefixes, false)
      raise ActionController::RoutingError.new("#{page_name} not found")
    end
  end
end
