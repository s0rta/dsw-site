class SiteController < ApplicationController
  respond_to :html
  rescue_from ActionView::MissingTemplate, with: :reraise_routing_error

  def index
    ctas = HomepageCta
      .active
      .relevant_to_cycles(AnnualSchedule.active_cycles)
      .includes(:track)
      .in_priority_order
    @two_up_ctas, @three_up_ctas = ctas.each_with_object([[], []]) { |cta, acc|
      if cta.track.present?
        acc.second << cta
      else
        acc.first << cta
      end
    }

    if @two_up_ctas.size == 3
      @three_up_ctas.unshift(@two_up_ctas.pop)
    end

    if @two_up_ctas.size > 4
      @three_up_ctas.unshift(*@two_up_ctas[4..-1])
      @two_up_ctas = @two_up_ctas[0..3]
    end
    flash[:notice] = "Thanks for registering! You will recieve a confirmation e-email shortly"
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
