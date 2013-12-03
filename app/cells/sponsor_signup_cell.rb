class SponsorSignupCell < Cell::Rails

  def display(snippet)
    @header = snippet.header
    @submit_text = snippet.submit_text
    render view: :display
  end

  def preview(snippet)
    display(snippet)
  end

  def options(snippet)
    @snippet = snippet
    render
  end
end
