class Venue < ApplicationRecord

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
