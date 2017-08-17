class Volunteership < ApplicationRecord

  include YearScoped

  belongs_to :user
  validates :user, presence: true

  has_many :volunteership_shifts
  has_many :volunteer_shifts, through: :volunteership_shifts
end
