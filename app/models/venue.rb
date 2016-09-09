class Venue < ActiveRecord::Base

  def self.alphabetical
    order(:name)
  end

  def address_for_google_maps
    URI.escape([ address, city, state ] * ', ')
  end

  def combined_address
    [ address, suite_or_unit, city, state ].compact * ', '
  end

end
