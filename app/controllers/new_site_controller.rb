class NewSiteController < ApplicationController

  respond_to :html

  def index
    @ctas = HomepageCta.active.relevant_to_cycles(EventSchedule.active_cycles).in_priority_order
    render template: page_partial
  end

  private

  def page_partial
    template_name = "new_site/#{params[:page].presence || 'index'}"
    lookup_context.find(template_name).virtual_path
  end
end
