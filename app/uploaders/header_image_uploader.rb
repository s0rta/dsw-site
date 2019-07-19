class HeaderImageUploader < ApplicationUploader
  # Create different versions of your uploaded files:
  version :thumb do
    process resize_to_limit: [100, 100]
    process :optimize
  end

  version :article_card do
    process resize_to_limit: [341 * 2, nil]
    process :optimize
  end

  version :article_page do
    process resize_to_fill: [1092 * 2, 464 * 2]
    process :optimize
  end

  version :content_card do
    process resize_to_limit: [659 * 2, nil]
    process :optimize
  end
end
