class NewSiteController < ApplicationController

  before_filter :verify_page_exists!

  def index
    @ctas = HomepageCta.active.relevant_to_cycles(EventSchedule.active_cycles).order('created_at DESC')
    render template: "new_site/#{params[:page].presence || 'index'}"
  end

  private

  def verify_page_exists!
    unless template_exists?(params[:page], _prefixes, false)
      raise ActionController::RoutingError.new("#{params[:page]} not found")
    end
  end
end
