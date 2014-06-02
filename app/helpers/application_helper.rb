module ApplicationHelper
  def process_with_pipeline(content)
    context = {
      asset_root: "/images/icons"
    }
    pipeline = HTML::Pipeline.new([
      HTML::Pipeline::MarkdownFilter,
      HTML::Pipeline::EmojiFilter,
      HTML::Pipeline::SanitizationFilter,
      HTML::Pipeline::AutolinkFilter
    ], context)
    result = pipeline.call content
    result[:output]
  end

  def current_year
    Date.today.year
  end

  def tracks_for_select
    Track.all.map { |t| [ t.name, t.id ] }
  end

end
