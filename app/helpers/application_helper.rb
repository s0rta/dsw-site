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
end
