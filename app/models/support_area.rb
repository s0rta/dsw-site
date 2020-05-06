class SupportArea < ApplicationRecord

  COLORS = %w[green teal blue purple gold orange red pink mint].freeze
  
  validates :name, presence: true
  validates :color, inclusion: {in: COLORS}

  def self.dropdown_options
    select("name as label, name as value, id")
  end
end
