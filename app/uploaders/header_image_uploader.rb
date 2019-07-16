class HeaderImageUploader < ApplicationUploader
  # Create different versions of your uploaded files:
  version :thumb do
    process resize_to_limit: [100, 100]
  end

  version :article_card do
    process resize_to_limit: [341 * 2, nil]
  end

  version :article_page do
    process resize_to_limit: [1070 * 2, nil]
  end

  version :content_card do
    process resize_to_limit: [659 * 2, nil]
  end
end
