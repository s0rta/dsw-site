class NewsletterSignupCell < Cell::Rails

  def display(snippet)
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
