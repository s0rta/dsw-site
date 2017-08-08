if Rails.env.production?
  Rails.application.configure do
    config.lograge.enabled = true
  end
end
