class Volunteership < ActiveRecord::Base

  belongs_to :user
  validates :user, presence: true

  has_many :volunteership_available_shifts
  has_many :available_shifts, through: :volunteership_available_shifts, class_name: 'VolunteerShift'

  has_many :volunteership_assigned_shifts
  has_many :assigned_shifts, through: :volunteership_assigned_shifts, class_name: 'VolunteerShift'

  after_initialize do
    self.year ||= Date.today.year
  end

  def self.for_current_year
    where(year: Date.today.year)
  end
  def self.for_previous_years
    where('year < ? ', Date.today.year)
  end
end
