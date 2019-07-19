class LogoUploader < ApplicationUploader
  # Add a white list of MIME types which are allowed to be uploaded.
  # For images you might use something like this:
  def content_type_whitelist
    %r{image/}
  end

  version :optimized do
    process :optimize
  end
end
