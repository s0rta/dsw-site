class SiteController < ApplicationController

  respond_to :html

  def index
    ctas = HomepageCta.
           active.
           relevant_to_cycles(AnnualSchedule.active_cycles).
           includes(:track).
           in_priority_order
    @two_up_ctas, @three_up_ctas = ctas.each_with_object([[], []]) do |cta, acc|
      if cta.track.present?
        acc.second << cta
      else
        acc.first << cta
      end
    end

    if @two_up_ctas.size == 3
      @three_up_ctas.unshift(@two_up_ctas.pop)
    end

    if @two_up_ctas.size > 4
      @three_up_ctas.unshift(*@two_up_ctas[4..-1])
      @two_up_ctas = @two_up_ctas[0..3]
    end

    @featured = HashWithIndifferentAccess.new(YAML.load(File.read(File.expand_path('../../data/featured.yml',  __FILE__))))

    render template: page_partial
  end

  private

  def page_partial
    template_name = "site/#{params[:page].presence || 'index'}".underscore
    lookup_context.find(template_name).virtual_path
  end
end
