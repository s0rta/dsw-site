module Publishable
  extend ActiveSupport::Concern

  has_one :publishing, as: :subject

  def published?
    publishing.present?
  end

  def publish!
    create_publishing(effective_at: Time.zone.now)
  end

  def unpublish!
    publishing.destroy!
  end
end