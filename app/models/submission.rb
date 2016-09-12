class Submission < ActiveRecord::Base

  WEEK_START = ActiveSupport::TimeZone.new('America/Denver').local(2016, 9, 12).at_beginning_of_day.freeze
  PUBLIC_STATES = %w(open_for_voting accepted confirmed).freeze

  SHOW_RATE = 0.3

  FORMATS = [ 'Presentation',
              'Panel',
              'Workshop',
              'Social event' ].freeze

  DAYS = { 1 => 'Weekend before',
           2 => 'Monday',
           3 => 'Tuesday',
           4 => 'Wednesday',
           5 => 'Thursday',
           6 => 'Friday',
           7 => 'Weekend after' }.freeze

  TIME_RANGES = [ 'Early morning',
                  'Breakfast',
                  'Morning',
                  'Lunch',
                  'Early afternoon',
                  'Afternoon',
                  'Happy hour',
                  'Evening',
                  'Late night' ].freeze

  include SearchableSubmission
  include YearScoped

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

  belongs_to :cluster

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
  after_save :subscribe_to_list

  after_initialize do
    self.year ||= Date.today.year
  end

  def to_param
    "#{self.id}-#{self.title.parameterize}"
  end

  def self.public
    where(state: PUBLIC_STATES)
  end

  def self.for_submittable_tracks
    joins(:track).
      where(tracks: { is_submittable: true })
  end

  def self.for_track(name)
    if name.present?
      joins(:track).
        where('LOWER(tracks.name) = LOWER(?)', name)
    else
      all
    end
  end

  def self.for_cluster(name)
    if name.present?
      joins(:cluster).
        where('LOWER(clusters.name) = LOWER(?)', name)
    else
      all
    end
  end

  def self.for_schedule_filter(filter, user)
    if filter == 'all'
      all
    elsif filter == 'mine'
      joins(:user_registrations).
        where(registrations: { user_id: user.id })
    elsif filter.present?
      joins(:track).
        joins('LEFT OUTER JOIN clusters ON submissions.cluster_id = clusters.id').
        where('LOWER(clusters.name) = LOWER(:name) OR LOWER(tracks.name) = LOWER(:name)', name: filter)
    else
      all
    end
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

  def self.for_start_day(day)
    if day_index = DAYS.invert[day.titleize]
      where(start_day: day_index)
    else
      all
    end
  end

  # State machine
  include SimpleStates

  states  :created,
          :on_hold,
          :open_for_voting,
          :accepted,
          :waitlisted,
          :confirmed,
          :rejected,
          :withdrawn

  event :place_on_hold,       to: :on_hold
  event :open_for_voting,     to: :open_for_voting
  event :waitlist,            to: :waitlisted
  event :accept,              to: :accepted
  event :reject,              to: :rejected
  event :confirm,             to: :confirmed
  event :withdraw,            to: :withdrawn

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
    "#{human_start_time} #{separator} #{human_end_time}".html_safe
  end

  def human_start_time
    start_hour.hours.since(Date.today.beginning_of_day).strftime('%l:%M%P')
  end

  def human_end_time
    end_hour.hours.since(Date.today.beginning_of_day).strftime('%l:%M%P')
  end

  def time_assigned?
    start_hour.present? &&
    end_hour.present? &&
    start_day.present? &&
    end_day.present?
  end

  def to_ics
    event
  end

  def promote_updates
    update(proposed_updates.merge(proposed_updates: nil))
  end

  def notify_track_chairs_of_update
    track.chairs.each do |chair|
      NotificationsMailer.notify_of_submission_update(chair, self).deliver_now
    end
  end

  def tags
    [ cluster.try(:name), (popular? ? 'Popular' : nil) ].compact * ', '
  end

  def popular?
    user_registrations.count * SHOW_RATE > (venue.try(:capacity) || Venue::DEFAULT_CAPACITY)
  end

  private

  def notify_track_chairs
    track.chairs.each do |chair|
      NotificationsMailer.notify_of_new_submission(chair, self).deliver_now
    end
  end

  def send_confirmation_notice
    NotificationsMailer.confirm_new_submission(self).deliver_now
  end

  def subscribe_to_list
    [ contact_email, submitter.email ].compact.uniq.each do |email|
      submitted_years = Submission.
                        joins(:submitter).
                        where('contact_email = :email OR users.email = :email', email: email).
                        pluck(:year).
                        sort.
                        map(&:to_s)
      confirmed_years = Submission.
                        confirmed.
                        joins(:submitter).
                        where('contact_email = :email OR users.email = :email', email: email).
                        pluck(:year).
                        sort.
                        map(&:to_s)
      ListSubscriptionJob.perform_async(email,
        submittedyears: submitted_years,
        confirmedyears: confirmed_years)
    end
  end
end
