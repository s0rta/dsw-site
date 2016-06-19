class Submission < ActiveRecord::Base

  WEEK_START = ActiveSupport::TimeZone.new('America/Denver').local(2015, 9, 28).at_beginning_of_day.freeze
  PUBLIC_STATES = %w(open_for_voting accepted confirmed).freeze

  FORMATS = [ 'Presentation',
              'Panel',
              'Workshop',
              'Social event' ]

  DAYS = { 1 => 'Weekend before',
           2 => 'Monday',
           3 => 'Tuesday',
           4 => 'Wednesday',
           5 => 'Thursday',
           6 => 'Friday',
           7 => 'Weekend after' }

  TIME_RANGES = [ 'Early morning',
                  'Breakfast',
                  'Morning',
                  'Lunch',
                  'Early afternoon',
                  'Afternoon',
                  'Happy hour',
                  'Evening',
                  'Late night' ]

  include SearchableSubmission

  has_paper_trail

  belongs_to :submitter, class_name: 'User'
  belongs_to :track
  belongs_to :venue

  has_many :votes, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :session_registrations, dependent: :destroy
  has_many :user_registrations, through: :session_registrations,
                                class_name: 'Registration',
                                source: :registration
  has_many :registrants, through: :user_registrations,
                         class_name: 'User',
                         source: :user

  validates :title, presence: true
  validates :description, presence: true
  validates :contact_email, presence: true
  validates :format, inclusion: {   in: FORMATS,
                                    allow_blank: true }
  # validates :start_day, inclusion: {  in: DAYS,
                                # allow_blank: true }
  # validates :end_day, inclusion: {  in: DAYS,
                                # allow_blank: true }
  # validates :time_range, inclusion: { in: TIME_RANGES,
                                      # allow_blank: true }
  # validates :start_hour, numericality: { greater_than_or_equal_to: 0, less_than: 24 }
  # validates :end_hour, numericality: { greater_than_or_equal_to: 0, less_than: 24 }
  validates :track_id, presence: true
  validates :location, length: { maximum: 255 }

  after_create :notify_track_chairs
  after_create :send_confirmation_notice
  after_create :subscribe_to_list

  after_initialize do
    self.year ||= Date.today.year
  end

  def to_param
    "#{self.id}-#{self.title.parameterize}"
  end

  def self.for_current_year
    where(year: Date.today.year)
  end

  def for_current_year?
    year == Date.today.year
  end

  def self.for_previous_years
    where('year < ? ', Date.today.year)
  end

  def self.public
    where(state: PUBLIC_STATES)
  end

  def public?
    PUBLIC_STATES.include?(state)
  end

  def self.confirmed
    where(state: 'confirmed')
  end

  def self.for_schedule
    confirmed.where('start_day IS NOT NULL AND end_day IS NOT NULL')
  end

  # State machine
  include SimpleStates

  states  :created,
          :on_hold,
          :open_for_voting,
          :accepted,
          :waitlisted,
          :confirmed,
          :rejected

  event :place_on_hold,       to: :on_hold
  event :open_for_voting,     to: :open_for_voting
  event :waitlist,            to: :waitlisted
  event :accept,              to: :accepted
  event :reject,              to: :rejected
  event :confirm,             to: :confirmed

  # Helpers

  def has_time_set?
    start_day &&
    start_hour &&
    end_day &&
    end_hour
  end

  def human_location_name
    if venue
      venue.name
    else
      'Location TBA'
    end
  end

  def human_start_day
    DAYS[start_day]
  end

  def human_end_day
    DAYS[end_day]
  end

  def start_datetime
    datetime = WEEK_START + (start_day.to_i - 2).days
    datetime += start_hour.hours if start_hour
    datetime
  end

  def end_datetime
    datetime = WEEK_START + (end_day.to_i - 2).days
    datetime += end_hour.hours if end_hour
    datetime
  end

  def human_time_range(separator = "&mdash;")
    "#{start_hour.hours.since(Date.today.beginning_of_day).strftime('%l:%M%P')} #{separator} #{end_hour.hours.since(Date.today.beginning_of_day).strftime('%l:%M%P')}".html_safe
  end

  def to_ics
    event
  end

  private

  def notify_track_chairs
    self.track.chairs.each do |chair|
      NotificationsMailer.notify_of_new_submission(chair, self).deliver
    end
  end

  def send_confirmation_notice
    NotificationsMailer.confirm_new_submission(self).deliver
  end

  def subscribe_to_list
    ListSubscriptionJob.perform_async(contact_email)
  end
end
