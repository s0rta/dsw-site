class BioCell < Cell::Rails

  def display(snippet)
    @full_name  = snippet.full_name
    @company    = snippet.company
    @title      = snippet.title
    @copy       = snippet.copy
    @image      = snippet.image
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
