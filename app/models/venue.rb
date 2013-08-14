class Venue < ActiveRecord::Base
  attr_accessible :contact_email, :contact_name, :contact_phone, :description, :name, :address, :city, :state
end
