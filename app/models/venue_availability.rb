class VenueAvailability < ApplicationRecord

  include YearScoped

  DAYS = {
    2 => 'Monday',
    3 => 'Tuesday',
    4 => 'Wednesday',
    5 => 'Thursday',
    6 => 'Friday'
}.freeze

  TIME_BLOCK = {
    1 => '8 - 10am',
    2 => '10 - 12pm',
    3 => '12 - 2pm',
    4 => '2 - 4pm',
    5 => '4 - 6pm',
    6 => '6 - 10pm'
}.freeze

  belongs_to :submission, optional: true
  belongs_to :venue

  validates :submission_id, uniqueness: true, allow_nil: true

  validates :year,
            :day,
            :time_block, presence: true

  validates :time_block, uniqueness: { scope: %i[year day venue_id] }

  def human_date_time
    "#{DAYS[day]} #{TIME_BLOCK[time_block]}"
  end

end
