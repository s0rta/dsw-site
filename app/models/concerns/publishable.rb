module Publishable
  extend ActiveSupport::Concern

  included do
    has_one :publishing, as: :subject, dependent: :destroy
  end

  class_methods do
    def published
      joins(:publishing).where("effective_at <= ?", Time.zone.now)
    end
  end

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
