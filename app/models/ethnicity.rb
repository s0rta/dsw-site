class Ethnicity < ApplicationRecord
  validates :name, presence: true, uniqueness: true
  has_many :registration_ethnicities, dependent: :restrict_with_error

  def self.active
    where(is_active: true)
  end

  def description
    name
  end
end
