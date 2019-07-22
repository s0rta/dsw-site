class AvatarUploader < ApplicationUploader
  include Gravatarify::Helper

  # Provide a default URL as a default if there hasn't been a file uploaded:
  def default_url(*_args)
    # For Rails 3.1+ asset pipeline compatibility:
    # ActionController::Base.helpers.asset_path("fallback/" + [version_name, "default.png"].compact.join('_'))
    # "/images/fallback/" + [version_name, "default.png"].compact.join('_')
    if version_name
      gravatar_url(model.try(:email), version_name.to_sym, default: :mm)
    else
      gravatar_url(model.try(:email), default: :mm)
    end
  end

  # Create different versions of your uploaded files:
  version :thumb do
    process resize_to_fill: [100, 100]
    process optimize: [{quality: 90, level: 7}]
  end
end
