class VolunteerShift < ApplicationRecord

  include YearScoped

  validates :name,
            presence: true

  validates :day,
            inclusion: {  in: Submission::DAYS },
            presence: true
  validates :start_hour,
            numericality: { greater_than_or_equal_to: 0, less_than: 24 },
            presence: true
  validates :end_hour,
            numericality: { greater_than_or_equal_to: 0, less_than: 24 },
            presence: true

  has_many :volunteership_shifts
  has_many :volunteerships, through: :volunteership_shifts
  belongs_to :venue, required: false

  def self.for_select
    for_current_year.order('day ASC').map { |s| [ s.full_name, s.id ] }
  end

  def full_name
    "#{name} (#{human_time_range}#{venue ? " at #{venue.name}" : ''})"
  end

  def start_datetime
    datetime = EventSchedule::WEEK_START_DATE + (day.to_i - 2).days
    datetime += start_hour.hours if start_hour
    datetime
  end

  def end_datetime
    datetime = EventSchedule::WEEK_START_DATE + (day.to_i - 2).days
    datetime += end_hour.hours if end_hour
    datetime
  end

  def human_start_time
    start_hour.hours.since(Date.today.beginning_of_day).strftime('%l:%M%P')
  end

  def human_end_time
    end_hour.hours.since(Date.today.beginning_of_day).strftime('%l:%M%P')
  end

  def human_time_range
    "#{human_start_time} to #{human_end_time}"
  end
end
