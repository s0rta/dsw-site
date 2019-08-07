class Venue < ApplicationRecord
  validates :name, presence: true, uniqueness: true

  validates :address,
    :city,
    :state, presence: true

  belongs_to :company, optional: true

  has_many :submissions, dependent: :restrict_with_error
  has_many :venue_availabilities, dependent: :restrict_with_error
  has_many :venue_adminships, dependent: :destroy
  has_many :admins, through: :venue_adminships, class_name: "User", source: :user

  accepts_nested_attributes_for :venue_availabilities
  accepts_nested_attributes_for :venue_adminships, allow_destroy: true

  DEFAULT_CAPACITY = 75

  def self.alphabetical
    order(:name)
  end

  def address_for_maps
    [address, city, state].map(&:presence).compact * ", "
  end

  def combined_address
    [address, suite_or_unit, city, state].map(&:presence).compact * ", "
  end

  def short_address
    [address, suite_or_unit].map(&:presence).compact * ", "
  end

  def contact_emails
    contact_email.split(",").map(&:strip)
  end

  def company_name
    company.try(:name)
  end

  def company_name=(value)
    self.company = Company.where("LOWER(name) = LOWER(?)", value).first_or_initialize(name: value)
  end
end
