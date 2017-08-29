class Company < ApplicationRecord
  validates :name, presence: true,
                   uniqueness: { case_sensitive: true }

  has_many :registrations, dependent: :restrict_with_error
  has_many :submissions, dependent: :restrict_with_error
end
