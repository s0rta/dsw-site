class Publishing < ApplicationRecord
  belongs_to :subject, polymorphic: true

  def self.for_homepage
    where(featured_on_homepage: true)
  end
end
