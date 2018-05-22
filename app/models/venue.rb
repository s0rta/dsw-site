class Venue < ApplicationRecord

  validates :name, presence: true, uniqueness: true

  validates :address,
            :city,
            :state, presence: true

  belongs_to :host, class_name: 'User', optional: true

  has_many :submissions, dependent: :restrict_with_error

  DEFAULT_CAPACITY = 75

  def self.alphabetical
    order(:name)
  end

  def address_for_google_maps
    URI.escape([ address, city, state ].map(&:presence).compact * ', ')
  end

  def combined_address
    [ address, suite_or_unit, city, state ].map(&:presence).compact * ', '
  end

  def short_address
    [ address, suite_or_unit ].map(&:presence).compact * ', '
  end

  def contact_emails
    contact_email.split(',').map(&:strip)
  end
end
