module ApplicationHelper
  def process_with_pipeline(content)
    pipeline = HTML::Pipeline.new [
      HTML::Pipeline::MarkdownFilter,
      HTML::Pipeline::SanitizationFilter,
      HTML::Pipeline::AutolinkFilter
    ]
    result = pipeline.call content
    result[:output]
  end
end
