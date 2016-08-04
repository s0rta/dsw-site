class VolunteerShift < ActiveRecord::Base
  validates :name,
            presence: true

  validates :day, inclusion: {  in: Submission::DAYS }
  validates :start_hour, numericality: { greater_than_or_equal_to: 0, less_than: 24 }, presence: true
  validates :end_hour, numericality: { greater_than_or_equal_to: 0, less_than: 24 }, presence: true

  has_many :volunteership_shifts
  has_many :volunteerships, through: :volunteership_shifts

  def self.for_select
    order('day ASC').map { |s| [ s.name, s.id ] }
  end
end
