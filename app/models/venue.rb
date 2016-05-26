class Venue < ActiveRecord::Base

  # Add to ActiveAdmin as strong params
  # attr_accessible :contact_email,
  #                 :contact_name,
  #                 :contact_phone,
  #                 :description,
  #                 :name,
  #                 :address,
  #                 :city,
  #                 :state

  def self.alphabetical
    order(:name)
  end

  def address_for_google_maps
    combined_address.gsub(' ','+')
  end

  def combined_address
    [ address, city, state ] * ', '
  end

end
