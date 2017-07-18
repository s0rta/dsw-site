# frozen_string_literal: true

if Rails.env.development? || Rails.env.test?
  Liquid.cache_classes = false
end

# Blow up on template errors
Liquid::Template.error_mode = :strict
