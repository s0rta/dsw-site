class PdfUploader < ApplicationUploader
  # Add a white list of MIME types which are allowed to be uploaded.
  # For images you might use something like this:
  def content_type_whitelist
    ["application/pdf"]
  end
end
