class Venue < ApplicationRecord

  validates :name, presence: true, uniqueness: true

  validates :address,
            :city,
            :state, presence: true

  has_many :submissions, dependent: :restrict_with_error
  has_many :volunteer_shifts, dependent: :restrict_with_error

  DEFAULT_CAPACITY = 75

  def self.alphabetical
    order(:name)
  end

  def address_for_google_maps
    URI.escape([ address, city, state ].compact * ', ')
  end

  def combined_address
    [ address, suite_or_unit, city, state ].compact * ', '
  end

  def short_address
    [ address, suite_or_unit ].compact * ', '
  end
end
